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
        - [ ] Show title + contents
        - [ ] Show new VC with selected page on tap
    - [ ] Check/uncheck published/sticky/static/draft/untagged
    - [ ] Request a particular page
    - [ ] Create a new page
        - [ ] Design editing
    - [ ] Edit a page
    - [ ] Delete a page
        - [ ] Swipe to delete
        - [ ] Edit table to delete
- [ ] Profile view
    - [ ] Edit api token, auth token
