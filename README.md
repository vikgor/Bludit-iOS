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
    - [ ] Error handling
- [ ] Authenticate
    - [ ] Decide when to ask for an auth key
- [ ] Main VC
    - [ ] Table view pagination
    - [ ] Request a particular page
        - [ ] Correctly set up UISearchController with Scope bars for published/sticky/draft/static
        - [ ] Fix deleting the found page
    - [ ] Create a new page
        - [ ] Add a send button on the right like in Mail and Messages apps
        - [ ] Change title dynamically from pageTitleTextField (like Mail app)
- [ ] Fix new lines after editing a page (maybe it's an API issue)
- [ ] Page view
    - [ ] Pass data from table view more elegantly
    - [ ] Cache cover image, check threads, and if everything else is ok with cover image
- [ ] Profile view
    - [ ] Edit api token, auth token
- [ ] Clean the code
    - [ ] add 'final' to the classes
    - [ ] make private when needed
    - [ ] remove prints and comments
    - [ ] Add documentation
