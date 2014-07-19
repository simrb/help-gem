Sdocs['Preface'] =<<Doc

=== What about the Simrb ?

Simrb is a framework for building server application. Many years ago, i had tried to find an application to do work of that i want to build something that could be used to run at server, and support the web service, web page, json data, xml data, and varied formats of data.

The important things in using is need to be simple, flexible, comfortable. I couldn't find it, So this is the reason why would i build this software called Simrb.


=== What responsibility Simrb does ?

Defining the directory architecture, basic command-line, configuration option, initialize loading workflow, that is all.
Doc

Sdocs['Directory architecture'] =<<Doc

Directory Architecture

/home/project
├── modules
│   ├── module_name1
│   │   ├── boxes                      ───│
│   │   │   ├── docs                      │ stores the documents
│   │   │   ├── tpls                      │ stores the templates, like *.erb
│   │   │   ├── migrations                │ stores the migration records
│   │   │   ├── langs                     │ stores the language file, *.en, *.de, *.cn , etc
│   │   │   │   ├── name.en               │ 
│   │   │   │   └── name.cn               │
│   │   │   ├── misc                      │ stores the Gemfile, and others
│   │   │   │   └── Gemfile               │
│   │   │   ├── installs                  │ stores the installing file that will be write into database, by
│   │   │   │   └── _mods                 │ the file name as the table name
│   │   │   ├── tool.rb                   │ these files will be loaded in command `$ 3s`
│   │   │   └── ...                    ───│
│   │   ├── views                         │ this is views layer,
│   │   │    ├── assets                   │ assets stores the file *.js, *.css, *.jpg, *.png, etc
│   │   │    │   ├── jqeury.js            │
│   │   │    │   └── style.css            │
│   │   │    ├── temp.slim                │ here is stores the template files that will be loaded when the route file
│   │   │    └── ...                   ───│ need it
│   │   ├── README.md                     │
│   │   ├── .gitignore                    │ this is logic layer, controler
│   │   ├── routes.rb                     │ any files, like routes.rb, config.rb, lib.rb, *.rb, all will be loaded in
│   │   └── ...                        ───│ startup of web server
│   │                                     
│   ├── module_name2                   ───│ other modules, you add it according to the requirement
│   ├── module_name3                      │
│   └── ...                               │
│
├── db
│   ├── backup
│   ├── upload
│   └── data.db
├── log
│   ├── thin.log
│   └── command_error_log.html
├── tmp
│   └── install.lock
└── scfg                                   put any options of static configuration here with an hash form

Doc

Sdocs['Command-line'] =<<Doc

==================
OVERVIEW
==================

init    - initialize a project directory
new     - create a new module
clone   - clone a module from remote repository
help    - show the help documentation
info    - show the information of current version of Simrb
start   - boot Simrb up via web server mode
kill    - kill the process of that web server you have booted up

==================
DESCRIPTION
==================

init
==================
Command format:

	$ simrb init [project_name] [module_name] [module_name2] ...

Example 1, initial a project

	$ simrb init project_name

Example 2, with creating a new module when initializing the project

	$ simrb init project_name module_name module_name2

Example 3, or, the module could be came from remote repository

	$ simrb init project_name module_name repo_name/module_name2


new
==================
Command format:

	$ simrb new [module_name] [module_name2] [module_name3] ...

note that this command only be used in root directory that includes the scfg file

Example 1, 

	$ simrb new blog

Example 2, new module more than one at the same time

	$ simrb new test test2 test3


clone
==================
Command format:

	$ simrb clone [repo_name/module_name] [repo_name/module_name2] [repo_name/module_name3] ...

its usage is as same as the new command, but just get the module from remote repository.

Example 1

	$ simrb clone repos_name/module_name repos_name2/module_name2


help
==================
Command format:

	$ simrb help

Example 1, if plus a number at the end, that will show the detail

	$ simrb help
	$ simrb help 1


info
==================
Command format:

	$ simrb info


start
==================
Command format:

	$ simrb start


kill
==================
Command format:

	$ simrb kill
Doc

