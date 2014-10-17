# 
# all of help documents is wrote here
#

Sdocs['Preface'] =<<Doc

This is a project to help you build the web service easily, it let you save more time on front-end developing of various terminal applications under the same background data provider.

The core goal of Simrb is focused on how to process background data and assist the data interaction of between front-end and back-end. It aims to get you a most pure utility, and efficient, modular, focused.

Doc


Sdocs['Directory'] =<<Doc

/home/project
├── modules
│   ├── module_name1
│   │   ├── store                 ───│ ---- DATA LAYER ----
│   │   │   ├── docs                 │ stores the documents
│   │   │   ├── tpls                 │ stores the templates, like *.erb
│   │   │   ├── migrations           │ stores the migration records
│   │   │   ├── langs                │ stores the language file, *.en, *.de, *.cn, etc
│   │   │   │   ├── name.en          │ 
│   │   │   │   └── name.cn          │
│   │   │   ├── misc                 │ stores the Gemfile, Gemfile.lock, and others
│   │   │   │   └── Gemfile          │
│   │   │   ├── installs             │ stores the installing file that will be write into database, by
│   │   │   │   └── base_info        │ the file name as the table name
│   │   │   ├── tool.rb              │ these files will be loaded in command `$ 3s`
│   │   │   └── ...                  │
│   │   ├── views                 ───│ ---- VIEW LAYER ----
│   │   │    ├── assets              │ assets dir stores the file *.js, *.css, *.jpg, *.png, etc
│   │   │    │   ├── jqeury.js       │
│   │   │    │   └── style.css       │
│   │   │    ├── temp.slim           │ here is stored the template files that will be loaded
│   │   │    ├── demo.slim           │ when the route file need it
│   │   │    ├── demo2.slim          │ 
│   │   │    └── ...                 │ 
│   │   ├── logic                 ───│ ---- LOGIC LAYER ----
│   │   │    ├── routes.rb           │ 
│   │   │    └── ...                 │ any files with suffix `rb` under the logic dir, or root dir 
│   │   ├── README.md                │ like routes.rb, logic/routes.rb, all will be loaded when
│   │   ├── .gitignore               │ the web server startup
│   │   ├── routes.rb                │ 
│   │   ├── demo.rb                  │ 
│   │   ├── demo2.rb                 │ 
│   │   └── ...                   ───│ 
│   │
│   ├── module_name2              ───│ other modules, you add it according to the requirement
│   ├── module_name3                 │
│   └── ...                          │
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
└── scfg                               put any options of static configuration here with an hash form

Doc

Sdocs['Module'] =<<Doc

Here is some core modules that is helpful to common application

	base  - some common methods
	data  - process data and interact with database
			provide an hash key-val variable as settings that stores in database
			provide the tag interface for classifing any datas
			provide the menu interface for managing the routers of applications

	view  - create shortcut view, generate view template, like form, list, table
	admin - manage data with build-in view

	file  - provide the file upload, download
	user  - about user login, logout, register, authorise

the base, data and view are core modules, the admin, file and user are extended modules for common requirement

Doc


Sdocs['Configuration'] =<<Doc

Simrb has two configuration files that are the scfg and spath under the root directory, the spath file stores all of paths of directory and file, scfg file stores the setting options of your project application.

Doc


Sdocs['Command-line'] =<<Doc

== Overview

Simrb includes many commands, `simrb`, `3s`. `simrb` is ran at global, except the `new` and `get`. The `3s` is only allowed to run under root directory of project. And the functionality of `3s` command could be extended by the file *.rb that is under the store dir.


== Description of command simrb

init    - initialize a project directory
new     - create a new module
get     - get a module from remote repository
help    - show the help documentation
info    - show the information of current version of Simrb
start   - boot Simrb up via web server mode
kill    - kill the process of that web server you have booted up


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


get
==================
Command format:

	$ simrb get [repo_name/module_name] [repo_name/module_name2] [repo_name/module_name3] ...

its usage is as same as the new command, but just get the module from remote repository.

Example 1

	$ simrb get repos_name/module_name repos_name2/module_name2


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


Sdocs['Hello World'] =<<Doc

When it finished installing at once, you can cook yourself by a `Hello World` demo.

Step 01, create a project directory called myapp

	$ simrb init myapp

Step 02, new a module called demo

	$ cd myapp && simrb new demo

Step 03, add code to file 

	$ echo 'get "/" do "Hello world" end' > modules/demo/routes.rb

Step 04, start up by web server to see what we have done

	$ simrb start

So, put the default address `http://0.0.0.0:3000` to browser
yup, if you see the `Hello world` is there, welcome to Simrb.

Doc
