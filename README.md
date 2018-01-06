# r-git

[![Build Status](https://travis-ci.org/jamesridgway/r-git.svg?branch=master)](https://travis-ci.org/jamesridgway/r-git)
[![Code Climate](https://codeclimate.com/github/jamesridgway/r-git/badges/gpa.svg)](https://codeclimate.com/github/jamesridgway/r-git)
[![Test Coverage](https://codeclimate.com/github/jamesridgway/r-git/badges/coverage.svg)](https://codeclimate.com/github/jamesridgway/r-git/coverage)

r-git is an executable gem that assists with managing multiple git repositories. The current functionality allows you to perform the following actions on multiple repositories at once:
* Pull
* Checkout
* Fetch
* View the status

![r-git - pull multiple repositories](https://files.james-ridgway.co.uk/r-git.png)

Imagine the scenario where you have several git projects under some parent:

    └── personal-projects
        ├── arbitary-sub-folder
        │   ├── projectX (git repo)
        │   ├── projectY (git repo)
        └── r-git (git repo)
    └── work-projects
        ├── repo-one (git repo)
        └── repo-two (git repo)


r-git has the concepts of 'roots' in our scenario `personal-projects` and `work-projects` are our roots. I register these by running the following from within each folder:

    $ rgit add-root

Running any of the following commands will result in that command being executed across all projects within the root:

* `rgit status`

  Status of all repositories

* `rgit pull`

  Execute git pull on all repositories

* `rgit fetch`

  Execute git fetch on all repositories

* `rgit checkout development`

  Execute `git checkout development` on all repositories

For example: executing `rgit fetch` from within any folder in `personal-projects` will run git fetch on all repositories in that folder/root.

It's that simple!

## Installation
Install it yourself as:

    $ gem install r-git

## Usage
r-git is an executable gem with the following CLI options.

    USAGE:
        rgit [global options] COMMAND [command options]
    
    GLOBAL OPTIONS:
        -v                         Run verbosely
    
    COMMANDS:
        add-root [PATH]            Add a root directory (defaults to pwd).
        remove-root [PATH]         Remove a root directory (defaults to pwd).
        show-roots                 Show roots.
        pull                       Git pull
        fetch                      Git fetch
        checkout BRANCH            Git checkout
        status                     Git status
        -h, --help                 Show this message
        version                    Show version

See the main description for examples of how to use r-git

## Development
After checking out the repo, run `bin/setup` to install dependencies. Then, run `rake spec` to run the tests. You can also run `bin/console` for an interactive prompt that will allow you to experiment. `rubocop` can be run to inspec code style.

To install this gem onto your local machine, run `bundle exec rake install`.

To release a new version, update the version number in `version.rb`, and then run `bundle exec rake release`, which will create a git tag for the version, push git commits and tags, and push the `.gem` file to [rubygems.org](https://rubygems.org).

## Contributing
Bug reports and pull requests are welcome on GitHub at https://github.com/jamesridgway/r-git.


## License
The gem is available as open source under the terms of the [MIT License](http://opensource.org/licenses/MIT).

