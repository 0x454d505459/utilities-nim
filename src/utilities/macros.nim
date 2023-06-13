import std/[macros, os, strutils]

macro includeDir*(dir:static[string]): untyped =
    ## Include all the files present in 'dir'
    ## Take this directory tree as example
    ## ```
    ## - myLibs/
    ##   - myfirstLib.nim
    ##   - myusefullLib.nim
    ##   - thingIshouldInclude.nim
    ## - main.nim
    ## ```
    ## Using inlcudeDir to include all 'myLibs' files would be done like so
    ## ```nim
    ## import utilities.macros
    ## includeDir "myLibs"
    ## ```
    ## The following will be converted at compile time to
    ## ```nim
    ## import utilities.macros
    ## inlclude myLibs/[myfirstLib, myusefullLib, thingIshouldInclude]
    ## ```


    let
        tree = nnkStmtList.newTree()
        inclStmt = nnkIncludeStmt.newTree()
        infixStmt = nnkInfix.newTree()
        bracket = nnkBracket.newTree()
    
    infixStmt.add(newIdentNode("/"), newIdentNode(dir))
    
    for file in os.walkDir(dir, true):
        if not file[1].endsWith(".nim"):continue
        echo file
        bracket.add(newIdentNode(file[1].split("/")[^1].split('.')[0]))
    
    infixStmt.add(bracket)
    inclStmt.add(infixStmt)
    tree.add(inclStmt)
    # echo tree.treeRepr
    result = tree

macro importDir*(dir:static[string]): untyped =
    ## Import all the files present in 'dir'
    ## Take this directory tree as example
    ## ```
    ## - myLibs/
    ##   - myfirstLib.nim
    ##   - myusefullLib.nim
    ##   - thingIshouldInclude.nim
    ## - main.nim
    ## ```
    ## Using importDir to import all 'myLibs' files would be done like so
    ## ```nim
    ## import utilities.macros
    ## importDir "myLibs"
    ## ```
    ## The following will be converted at compile time to
    ## ```nim
    ## import utilities.macros
    ## import myLibs/[myfirstLib, myusefullLib, thingIshouldInclude]
    ## ```
    let
        tree = nnkStmtList.newTree()
        impStmt = nnkImportStmt.newTree()
        infixStmt = nnkInfix.newTree()
        bracket = nnkBracket.newTree()
    
    infixStmt.add(newIdentNode("/"), newIdentNode(dir))
    
    for file in os.walkDir(dir, true):
        if not file[1].endsWith(".nim"):continue
        echo file
        bracket.add(newIdentNode(file[1].split("/")[^1].split('.')[0]))
        # echo file
    
    infixStmt.add(bracket)
    impStmt.add(infixStmt)
    tree.add(impStmt)
    echo tree.treeRepr
    # result = tree