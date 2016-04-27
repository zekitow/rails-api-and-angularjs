# Angular JS + Rails Crud Example

## Run

### 1. Install Postgres

    brew update
    brew install postgres

#### 1.1 Run PG

    postgres -D /usr/local/var/postgres

#### 1.2 Create a new User

    createuser --interactive

And add it as superuser, just to run locally (never do that in production!)

    Enter name of role to add: hotels
    Shall the new role be a superuser? (y/n) Y

### 2. Install RVM

    curl -sSL https://get.rvm.io | bash -s stable

#### 2.1 Export RVM to PATH and reload the bashrc

    export PATH="$PATH:$HOME/.rvm/bin"
    source ~/.bashrc

#### 2.2. Test the RVM

    type rvm | head -n 1

The terminal should show something like "rvm is a shell function".

#### 3. Install Ruby

    rvm install ruby-2.2.2

#### 4. Install the project dependencies (inside the project folder)

    bundle install

#### 5. Create the database and migrations

    bundle exec rake db:create db:migrate db:seed

#### 6. Run the tests

    rspec

#### 7. Run the server

    rails s -p 3000

Now you enviorement is read to use and you can find all hotels at: * http://localhost:3000/api/hotels *

# Questions ?

Please, get in touch by e-mail at zeca@digup.io or by Skype (zekitow).