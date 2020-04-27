#  Bludit iOS Client

Bludit version: 3.12. 
API plugin version: 3.12.

### Initial setup:
Get your API Token here:
Plugins - API - Settings
Get your Authentication Token here:
Users - Admin user - Security

TODO:
- [ ] API Client
    - [ ] Fix case when host name includes slashes (e.g. CMS is located at "website.com/blog" instead of "website.com")
    - [ ] Error handling
- [ ] Errors
    - [ ] Auth
        - [ ] If website doesn't use https - alert and not let in
    - [ ] Main
        - [ ] If details are incorrect (Client error while bluditAPI.listPages()) - show alert with “Go back” button
- [ ] Login view
    - [ ] Format website domain from "https://www.domain.com/" to "domain.com"
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
    - [ ] Pass data from table view more elegantly?
    - [ ] Cache cover image, check threads, and if everything else is ok with cover image
- [ ] Settings view
    - [ ] Log out button
        - [ ] Clear the cache
- [ ] Clean the code
    - [ ] add 'final' to the classes
    - [ ] make private when needed
    - [ ] remove prints and comments
    - [ ] Add documentation
