# Development Notes
With this project, I chose to work my way up from the database schema up to the views and implementing tests along the way to emulate the best practice of test-driven development.

## Objective
The goal is to be able to implement a booking management system that would display a user's quotations, bookings, billings, and maybe their contacts. These would be the main pages of the application and I plan to implement turbo frames on each one and see where I can go from there. 

## Schema
I based most of the tables around the spreadsheets commonly used by my wife. I started building tables from Users all the way down to the billings table. It took 2 days to build the base schema which looks like this:
![Initial Schema](app/assets/images/Schema_051324.jpg)

This is just the base I'm working with, which means its likely to change. The current associations are also not set in stone and would be updated as needed.

## Tests
### Setup
To properly set-up FactoryBot and Shoulda-matchers, the following code should be added in `spec/rails_helper.rb`
```ruby
# Should be under Rspec.configure
config.include FactoryBot::Syntax::Methods

# After the configure block
Shoulda::Matchers.configure do |config|
  config.integrate do |with|
    with.test_framework :rspec
    with.library :rails
  end
end

# Not sure if this is needed but I placed:
require 'factory_bot_rails'
# After the built-in comment to "add additional require below this line"
```

To be able to use Devise::Test helpers, the following should be added in `spec/rails_helper.rb`
```ruby
config.include Devise::Test::IntegrationHelpers, type: :request
```
### Implementation
#### Models
- Tests were implemented alongside model associations, validations, and basic methods.
- As of 05/23/24
  ```bash
  Finished in 0.99889 seconds (files took 1.69 seconds to load)
  87 examples, 0 failures
  ```
#### Controllers
- As of 05/23/24
  ```bash
  Finished in 2.71 seconds (files took 1.64 seconds to load)
  43 examples, 0 failures
  ```
#### Helpers
- As of 05/23/24
  ```bash
  Finished in 0.40748 seconds (files took 1.6 seconds to load)
  6 examples, 0 failures, 3 pending
  ```

## Processes Learned
### Using wkdhtmltopdf To Generate PDFs
#### Resource:
- [Wicked PDF](https://github.com/mileszs/wicked_pdf?tab=readme-ov-file#wicked-pdf----)
- [Using Flex with wicked_pdf](https://stackoverflow.com/questions/57020675/using-flex-css-with-wkhtmltopdf)
- [Using Borders with wicked_pdf](https://stackoverflow.com/questions/65825023/print-page-borders-on-a-multi-page-output-using-wkhtmlltopdf)
#### Installation:
Besides adding the necessary gems in my `GemFile` as per the documentation. I also installed wickedpdf in my system. I am not sure if this was a necessary step. If problems arise in the future when this project is deployed, I'll need to document the steps I needed to do to allow for proper deployment.

### Scoping with devise
Since I'm allowing user creation under unique companies, I needed to scope users under a company ID:
```ruby
validates :email, presence: true, uniqueness: { case_sensitive: false, scope: :company_id }
```

Due to `devise` it wasn't a walk in the park to just test it and expect it to work on the get go. The following needed to be added in the user model:
```ruby
def will_save_change_to_email?
    false
  end

  def email_changed?
    false
  end
```
I also needed a migration file to add indexes and remove the email index from user:
```ruby
def change
  add_index :users, [:email, :company_id], unique: true
  remove_index :users, :email
end
```
Finally, a config needs to be added in `initializers/devise.rb`:
```ruby
config.authentication_keys = [ :email, :company_id ]
```

#### Resources:
- [Stack Overflow](https://stackoverflow.com/questions/57569530/custom-email-unique-validation-not-working-on-devise)
- [Stack Overflow2](https://stackoverflow.com/questions/18338353/devise-allow-email-uniqueness-within-scope)

#### Thoughts:
At this stage of development, I haven't implemented controllers or views yet. If this causes issues on those fronts, I need to update this.

### CSS with Bootstrap Present on Creation
When I was adding custom fonts, I noticed that `Hotwire::LiveReload` wasn't updating when I made css changes which I found quite weird. Then checking further, I noticed that I can't even add custom css scripts.

Upon searching stack overflow, apparently I'm supposed to watch the css using `yarn watch:css` which would require a separate terminal in order for css changes to be made.

It's also on the scripts under `package.json` in the application's root directory.

### Constraining routes
In this project, I chose to have a constraint added to accessing the admin dashboard. I wanted the user to be authenticated first, then a check to happen if the users `admin` column is true.

Searching through posted questions in StackOverflow, I found this:
```ruby
constraints: lambda { |request| request.env['warden'].user.admin? 
```
I added this constraint when setting my root paths, they are structured this way since the routes are match top to bottom and having the two other root paths above this one would have the admin login to the dashboard index first.

```ruby
authenticated :user do
  root "admin/dashboard#index", as: :admin_root, constraints: lambda { |request| request.env['warden'].user.admin? unless request.env['warden'].user.nil? }
  namespace :admin do
    resources :companies, only: [ :index, :show, :update ]
  end

  root "dashboard#index", as: :auth_root
end
root "pages#index"
```

### Nesting Forms & Using Stimulus to dynamically add or remove fields
#### Nesting Part
While creating a quotation form, I ran across an issue where the params I'm expecting to receive weren't complete. Specifically, my `Quote_Line_Item` which belongs to a `Quotation` would require several of the same fields since some charges have different descriptions and prices.

What I found to do this was to add a `fields_for` in my new quotation form:
```ruby
<%= f.fields_for :quote_line_items do |item| %>
  <%= render 'users/quotations/new_quotelineitem', f: item %>
<% end %>
```

While this was able to nest `quote_line_item`'s attributes, adding another of the same code was not enough. What I needed was an array of `quote_line_items` in the params so that I can work on it on the create action.

To do this, I found that I needed to add lines in my model and controller:
```ruby
# quotation.rb
class Quotation < ApplicationRecord
  has_many :quote_line_items

  accepts_nested_attributes_for :quote_line_items
end

# quotations_controller.rb
class Users::QuotationsController < ApplicationController
  before_action :authenticate_user!

  def new
    @quotation = current_user.quotations.new
    @quotation.quote_line_items.build
  end

  private

  def quotation_params
    params.require(:quotation).permit(
      :status, :exchange_rate, :origin, :destination, :incoterm, client: [:name, :address],
      quote_line_items_attributes: [:description, :currency, :cost, :frequency, :quantity, :total]
    )
  end
end
```
The underlying reasons why this needs to be done is still quite hazy at this point, but I think I needed to add `accepts_nested_attributes_for` in my model so that a form would allow for multiple `fields_for` for `quote_line_items` since the association to it is `has_many`

As for the quotation params, adding a `_attributes` to `quote_line_items`, I'm still very confused by it. My understanding of it (as of writing this) is that rails uses it to distinguish between the normal attributes of a model and the nested attribute. Basically instead of it calling `quotation.description`, it knows that it's supposed to be `quotation.quote_line_items.description`. 

This whole process I think is usually for when you just want to create using one model without using `transactions`. So that rails will do `Quotation.create(status: something, quote_line_items: { description: something })` instead of the usual way of `Quotation.create(status: something)` then `Quote_Line_Item.create(description: something, quotation_id: that_first_one)`

#### Stimulus Part
Once I had the nesting part figured out, the next problem to solve was looking for the best way to add another `quote_line_item` field. I didn't want to have a set number of `quote_line_items` to just render on the screen. Users would find that annoying as well should they need more.

At first, I thought of using turbo streams but ultimately decided that maybe getting more used to stimulus would be nicer. Thus here's what the stimulus controller looks like:
```js
export default class extends Controller {
  static targets = ["container", "template"]

  initialize() {
    this.indexValue = 1
  }

  add(e) {
    e.preventDefault()
    
    const newIndex = this.indexValue++
    const content = this.templateTarget.innerHTML
    .replace(/name="quotation\[quote_line_items_attributes\]\[\d+\]\[/g, `name="quotation[quote_line_items_attributes][${newIndex}][`)
    .replace(/id="quotation_quote_line_items_attributes_\d+_/g, `id="quotation_quote_line_items_attributes_${newIndex}_`)
    .replace("d-none","")

    this.containerTarget.insertAdjacentHTML('beforeend', content)
  }

  remove(e) {
    e.preventDefault()
    const lineItemEl = e.target.closest('.row')
    const lineItemIndex = this.getIndexFromEl(lineItemEl)

    if (lineItemIndex !== null) {
      lineItemEl.remove()
      this.indexValue--
      this.updateIndices(lineItemIndex)
    }
  }

  getIndexFromEl(el) {
    const idPattern = /quote_line_items_attributes_(\d+)_/
    const match = el.querySelector('[id]')?.id.match(idPattern)
    return match ? parseInt(match[1], 10) : null
  }

  updateIndices(startIndex) {
    const lineItemElements = this.containerTarget.querySelectorAll('.row')

    lineItemElements.forEach((element, index) => {
      if (index >= startIndex) {
        const newIndex = index 
        const namePattern = /name="quotation\[quote_line_items_attributes\]\[\d+\]\[/g
        const idPattern = /id="quotation_quote_line_items_attributes_\d+_/g

        element.innerHTML = element.innerHTML
        .replace(namePattern, `name="quotation[quote_line_items_attributes][${newIndex}][`)
        .replace(idPattern, `id="quotation_quote_line_items_attributes_${newIndex}_`)
      }
    })
  }
```
In hindsight, this looks like a pretty hacky way of doing it. But I get to learn more javascript, I guess. Maybe I'll also try another branch to test if turbo streams would've been quicker since I can just use the `@quotation.quote_line_items.build` variable in my new controller to pass on to the partial.

After completing this part of the feature, I'm still considering looking into the use of turbo streams and not stimulus. This is because I spent a considerable amount of time tinkering with the stimulus controllers just to make sure they worked properly and would pass the correct params. There's also an issue with `updateIndices` that would not save the values currently on the given row and thus the last few commits were focused on making sure the stimulus controller was showing, and retaining, the correct values on field removal and/or updates.

## Issues Encountered
### Popper not working properly with importmaps
While trying to implement navbar with dropdowns, I noticed that they were not functioning properly. Checking on the console, it looks like `@popperjs/core` wasn't being loaded properly.

A [StackOverflow answer](https://stackoverflow.com/questions/77929977/ruby-on-rails-7-popperjs-core-errors) about this says that there's currently an issue with importmaps. 

What I did to resolve this issue was to add this pin on `config/importmap.rb`.
```ruby
pin "@popperjs/core", to: "https://cdn.jsdelivr.net/npm/@popperjs/core@2.11.8/dist/umd/popper.min.js"
```
Then importing in in `app/javascript/application.js`
```ruby
import "@popperjs/core"

# It's vital that this is imported before bootstrap.
```

Doing this I was able to make dropdowns and toasts work.