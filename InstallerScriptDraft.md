# Draft for stdlib's installer script:

- The script called something like: "Stdlib_Installer_RunMe_from_the_modules_folder.bat"

- **Procedure:** 
  - ListFolder = List each folders in modules
  - If ListFolder.Length != 0
    - if folder .legacy not exists md ".legacy"
    - if folder .deprecated not exists md ".deprecated"
    - Foreach folder in ListFolder
      - file currmodule = is module.json exists in folder ? folder : Null
      - if currmodule
        - Tuple<K,V> meta = read module.json
        - result = searchin meta.Get("depends") the value "stdlib", "sdk", "sdk_mojo", "sdk_sdl2" or "sdk_games" ? value
        // *This code places any old std-related modules in .deprecated and any other modules that depends of the deprecated files into .legacy - Peoples are implicitly invited to use stdlib stuff, the script will automatically knows that a module is made for the next generation of std for Monkey2. The modules not made for stdlib are placed into .legacy in waiting for upgrades from their original authors. The modules from the std ecosystem are placed into .deprecated*
        - if result!
           - result = searchin meta.Get("depends") the value "std", "mojo"... in the Key "depends"
           - if result! move currmodule into ".legacy" else move currmodule into ".deprecated"
  - Call the compiler, compile stdlib with option -verbose -release -debug
    
