Sdocs['About us'] =<<Doc
Directory structure
Doc

Sdocs['init	- initialize a project directory'] =<<Doc
Command format:

	$ simrb init [project_name] [module_name] [module_name2] ...

Example 1, initial a project

	$ simrb init project_name

Example 2, with creating a new module when initializing the project

	$ simrb init project_name module_name module_name2

Example 3, or, the module could be come from remote

	$ simrb init project_name simrb/module_name simrb/module_name2
Doc

Sdocs['new - create a new module'] =<<Doc
Command format:

	$ simrb new [module_name] [module_name2] [module_name3] ...

Example 1

	$ simrb new blog

Example 2, new module more than one at same time
	
	$ simrb new test test2 test3
Doc

Sdocs['clone - clone a module from repository'] =<<Doc
Command format:

	$ simrb clone [repo_name/module_name] [repo_name/module_name2] [repo_name/module_name3] ...

Example 1
		
	$ simrb clone simrb/system simrb/test someone_repository/someone_module

any more usages as the new command
Doc

Sdocs['help	- show the help documentation'] =<<Doc
Command format:
	
	$ simrb help

Example 1, see the preview

	$ simrb help

Example 2, see the details with number

	$ simrb help 0
	$ simrb help 1
Doc

Sdocs['info	- show the information of current version of Simrb'] =<<Doc
Command format:

	$ simrb info
Doc

Sdocs['start - boot Simrb up via web server mode'] =<<Doc
Command format:

	$ simrb start
Doc

Sdocs['kill	- kill the process of web server'] =<<Doc
Command format:

	$ simrb kill
Doc

