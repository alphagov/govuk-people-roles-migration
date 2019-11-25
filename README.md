# govuk-people-roles-migration

Scripts used during the migration of people and roles.

## Instructions

1. Install the dependencies using Homebrew:

   ```sh
   $ brew bundle
   ```

2. Run collections against the live content store.

   ```sh
   $ cd ~/govuk/collections
   $ ./startup.sh --live
   ```

2. Download screenshots of each person and role.

   ```sh
   $ ./download.rb
   ```

   **Note:** this takes many hours to complete, perhaps leave it running
   overnight.
