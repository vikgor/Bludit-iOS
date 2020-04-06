#  Bludit iOS Client

Bludit version: 3.12

### Initial setup:
Get your API Token here:
Plugins - API - Settings
Get your Authentication Token here:
Users - Admin user - Security

TODO:
- [ ] API Client
    - [x] Get pages/tags (GET)
        - [x] published/sticky/static/draft/untagged
        - [x] Get pages/tags by key
            - [x] Fix query from "This example" to "this-example"
    - [x] Create new page (POST)
    - [x] Edit page (PUT)
    - [x] Delete page (DELETE)
    - [ ] Fix case when host name includes slashes (e.g. CMS is located at "website.com/blog" instead of "website.com")
- [ ] Authenticate
    - [ ] Type website name + API Token
    - [ ] Save them in UserDefaults, for now
    - [ ] Show Main VC
- [ ] Main VC
    - [ ] Table with the last 15 published pages
        - [x] Show title + contents
        - [x] Show new VC with selected page on tap
        - [ ] Show all the pages instead of last 10
        - [ ] Fix refreshing (it needs to be refreshed twice before reloading the table after creating the page)
    - [ ] Check/uncheck published/sticky/static/draft/untagged
    - [ ] Request a particular page
        - [ ] Fix deleting the found page
    - [ ] Create a new page
        - [x] Design editing
        - [ ] Add a send button on the right like in Mail and Messages apps
        - [ ] Change title dynamically from pageTitleTextField (like Mail app)
        - [x] If either of the fields is empty, on send the post show alert with promt (Go back/Cancel) d
        - [x] If either of the fields is not empty, on the cancellaion show Action Sheet (Delete/Save draft)
        - [ ] Fix the automatic heights
        - [x] Clean the code for create()
    - [ ] Edit a page
    - [ ] Delete a page
        - [x] Swipe to delete
        - [ ] Edit table to delete
- [ ] Page view
    - [ ] Make label fit the screen somehow
    - [ ] Pass data from table view more elegantly
    - [ ] Show cover image if it's set up for the page
        - [ ] Probably need to fix the API Client
    - [ ] Scroll all page, not only textView
    - [ ] Encode HTML text 
- [ ] Profile view
    - [ ] Edit api token, auth token
