#  Bludit iOS Client

Bludit version: 3.12

### Initial setup:
Get your API Token here:
Plugins - API - Settings
Get your Authentication Token here:
Users - Admin user - Security

TODO:
- [ ] API Client
    - [ ] Fix case when host name includes slashes (e.g. CMS is located at "website.com/blog" instead of "website.com")
    - [ ] Fix optional image in PageDetails
- [ ] Authenticate
    - [ ] Move view up when keyboard is presented
    - [ ] Decide when to ask for an auth key
- [ ] Main VC
    - [ ] Table with the last 15 published pages
        - [ ] Show 10 last pages, then on bottom scroll show 10 more and so on
    - [ ] Check/uncheck published/sticky/static/draft/untagged
    - [ ] Request a particular page
        - [ ] Correctly set up UISearchController with Scope bars for published/sticky/draft/static
        - [ ] Fix deleting the found page
    - [ ] Create a new page
        - [ ] Add a send button on the right like in Mail and Messages apps
        - [ ] Change title dynamically from pageTitleTextField (like Mail app)
    - [ ] Edit a page
- [ ] Page view
    - [ ] Pass data from table view more elegantly
    - [ ] Cache cover image, check threads, force casts and if everything else is ok with cover image
- [ ] Profile view
    - [ ] Edit api token, auth token
