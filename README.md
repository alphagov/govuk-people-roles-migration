# govuk-people-roles-migration

Scripts used during the migration of people and roles.

## Instructions

1. Install the dependencies using Homebrew:

   ```sh
   $ brew bundle
   $ npm install -g blink-diff
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

3. Compare the screenshots of Whitehall and Collections.

   ```sh
   $ ./compare.rb
   ```

   **Note:** this takes _many_ hours to complete, perhaps leave it running
   for a few days.

4. Analyse the diff screenshots stored in the `comparisons` folder to decide
   whether to go live with the migration.
