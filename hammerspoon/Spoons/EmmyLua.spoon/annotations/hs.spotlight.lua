--# selene: allow(unused_variable)
---@diagnostic disable: unused-local

-- This module allows Hammerspoon to preform Spotlight metadata queries.
--
-- This module will only be able to perform queries on volumes and folders which are not blocked by the Privacy settings in the System Preferences Spotlight panel.
--
-- A Spotlight query consists of two phases: an initial gathering phase where information currently in the Spotlight database is collected and returned, and a live-update phase which occurs after the gathering phase and consists of changes made to the Spotlight database, such as new entries being added, information in existing entries changing, or entities being removed.
--
-- The syntax for Spotlight Queries is beyond the scope of this module's documentation. It is a subset of the syntax supported by the Objective-C NSPredicate class.  Some references for this syntax can be found at:
--    * https://developer.apple.com/library/content/documentation/Carbon/Conceptual/SpotlightQuery/Concepts/QueryFormat.html
--    * https://developer.apple.com/library/content/documentation/Cocoa/Conceptual/Predicates/Articles/pSyntax.html
--
-- Depending upon the callback messages enabled with the [hs.spotlight:callbackMessages](#callbackMessages) method, your callback assigned with the [hs.spotlight:setCallback](#setCallback) method, you can determine the query phase by noting which messages you have received.  During the initial gathering phase, the following callback messages may be observed: "didStart", "inProgress", and "didFinish".  Once the initial gathering phase has completed, you will only observe "didUpdate" messages until the query is stopped with the [hs.spotlight:stop](#stop) method.
--
-- You can also check to see if the initial gathering phase is in progress with the [hs.spotlight:isGathering](#isGathering) method.
--
-- You can access the individual results of the query with the [hs.spotlight:resultAtIndex](#resultAtIndex) method. For convenience, metamethods have been added to the spotlightObject which make accessing individual results easier:  an individual spotlightItemObject may be accessed from a spotlightObject by treating the spotlightObject like an array; e.g. `spotlightObject[n]` will access the n'th spotlightItemObject in the current results.
---@class hs.spotlight
local M = {}
hs.spotlight = M

-- Get or specify the specific messages that should generate a callback.
--
-- Parameters:
--  * `messages` - an optional table or list of items specifying the specific callback messages that will generate a callback.  Defaults to { "didFinish" }.
--
-- Returns:
--  * if an argument is provided, returns the spotlightObject; otherwise returns the current values
--
-- Notes:
--  * Valid messages for the table are: "didFinish", "didStart", "didUpdate", and "inProgress".  See [hs.spotlight:setCallback](#setCallback) for more details about the messages.
function M:callbackMessages(messages, ...) end

-- A list of defined attribute keys as discovered in the macOS 10.12 SDK framework headers.
--
-- This table contains a list of attribute strings that may be available for spotlightSearch result items.  This list is by no means complete, and not every result will contain all or even most of these keys.
--
-- Notes:
--  * This list was generated by searching the Framework header files for string constants which matched one of the following regular expressions: "kMDItem.+", "NSMetadataItem.+", and "NSMetadataUbiquitousItem.+"
---@type table
M.commonAttributeKeys = {}

-- Returns the number of results for the spotlightObject's query
--
-- Parameters:
--  * None
--
-- Returns:
--  * if the query has collected results, returns the number of results that match the query; if the query has not been started, this value will be 0.
--
-- Notes:
--  * Just because the result of this method is 0 does not mean that the query has not been started; the query itself may not match any entries in the Spotlight database.
--  * A query which ran in the past but has been subsequently stopped will retain its queries unless the parameters have been changed.  The result of this method will indicate the number of results still attached to the query, even if it has been previously stopped.
--
--  * For convenience, metamethods have been added to the spotlightObject which allow you to use `#spotlightObject` as a shortcut for `spotlightObject:count()`.
---@return number
function M:count() end

-- A table of key-value pairs describing predefined search scopes for Spotlight queries
--
-- The keys for this table are as follows:
--  * `iCloudData`              - Search all files not in the Documents directories of the app’s iCloud container directories.
--  * `iCloudDocuments`         - Search all files in the Documents directories of the app’s iCloud container directories.
--  * `iCloudExternalDocuments` - Search for documents outside the app’s container.
--  * `indexedLocalComputer`    - Search all indexed local mounted volumes including the current user’s home directory (even if the home directory is remote).
--  * `indexedNetwork`          - Search all indexed user-mounted remote volumes.
--  * `localComputer`           - Search all local mounted volumes, including the user home directory. The user’s home directory is searched even if it is a remote volume.
--  * `network`                 - Search all user-mounted remote volumes.
--  * `userHome`                - Search the user’s home directory.
--
-- Notes:
--  * It is uncertain at this time if the `iCloud*` search scopes are actually useful within Hammerspoon as Hammerspoon is not a sandboxed application that uses the iCloud API fo document storage. Further information on your experiences with these scopes, if you use them, is welcome in the Hammerspoon Google Group or at the Hammerspoon Github web site.
---@type table
M.definedSearchScopes = {}

-- Returns the grouped results for a Spotlight query.
--
-- Parameters:
--  * None
--
-- Returns:
--  * an array table containing the grouped results for the Spotlight query as specified by the [hs.spotlight:groupingAttributes](#groupingAttributes) method.  Each member of the array will be a spotlightGroupObject which is detailed in the `hs.spotlight.group` module documentation.
--
-- Notes:
--  * The spotlightItemObjects available with the `hs.spotlight.group:resultAtIndex` method are the subset of the full results of the spotlightObject that match the attribute and value of the spotlightGroupObject.  The same item is available through the spotlightObject and the spotlightGroupObject, though likely at different indicies.
function M:groupedResults() end

-- Get or set the grouping attributes for the Spotlight query.
--
-- Parameters:
--  * `attributes` - an optional table or list of items specifying the grouping attributes for the Spotlight query.  Defaults to an empty array.
--
-- Returns:
--  * if an argument is provided, returns the spotlightObject; otherwise returns the current values
--
-- Notes:
--  * Setting this property while a query is running stops the query and discards the current results. The receiver immediately starts a new query.
--  * Setting this property will increase CPU and memory usage while performing the Spotlight query.
--
--  * Thie method allows you to access results grouped by the values of specific attributes.  See `hs.spotlight.group` for more information on using and accessing grouped results.
--  * Note that not all attributes can be used as a grouping attribute.  In such cases, the grouped result will contain all results and an attribute value of nil.
function M:groupingAttributes(attributes, ...) end

-- Returns a boolean specifying whether or not the query is in the active gathering phase.
--
-- Parameters:
--  * None
--
-- Returns:
--  * a boolean value of true if the query is in the active gathering phase or false if it is not.
--
-- Notes:
--  * An inactive query will also return false for this method since an inactive query is neither gathering nor waiting for updates.  To determine if a query is active or inactive, use the [hs.spotlight:isRunning](#isRunning) method.
---@return boolean
function M:isGathering() end

-- Returns a boolean specifying if the query is active or inactive.
--
-- Parameters:
--  * None
--
-- Returns:
--  * a boolean value of true if the query is active or false if it is inactive.
--
-- Notes:
--  * An active query may be gathering query results (in the initial gathering phase) or listening for changes which should cause a "didUpdate" message (after the initial gathering phase). To determine which state the query may be in, use the [hs.spotlight:isGathering](#isGathering) method.
---@return boolean
function M:isRunning() end

-- Creates a new spotlightObject to use for Spotlight searches.
--
-- Parameters:
--  * None
--
-- Returns:
--  * a new spotlightObject
function M.new() end

-- Creates a new spotlightObject that limits its searches to the current results of another spotlightObject.
--
-- Parameters:
--  * `spotlightObject` - the object whose current results are to be used to limit the scope of the new Spotlight search.
--
-- Returns:
--  * a new spotlightObject
function M.newWithin(spotlightObject, ...) end

-- Specify the query string for the spotlightObject
--
-- Parameters:
--  * a string containing the query for the spotlightObject
--
-- Returns:
--  * the spotlightObject
--
-- Notes:
--  * Setting this property while a query is running stops the query and discards the current results. The receiver immediately starts a new query.
--
--  * The query string syntax is not simple enough to fully describe here.  It is a subset of the syntax supported by the Objective-C NSPredicate class.  Some references for this syntax can be found at:
--    * https://developer.apple.com/library/content/documentation/Carbon/Conceptual/SpotlightQuery/Concepts/QueryFormat.html
--    * https://developer.apple.com/library/content/documentation/Cocoa/Conceptual/Predicates/Articles/pSyntax.html
--
--  * If the query string does not conform to an NSPredicate query string, this method will return an error.  If the query string does conform to an NSPredicate query string, this method will accept the query string, but if it does not conform to the Metadata query format, which is a subset of the NSPredicate query format, the error will be generated when you attempt to start the query with [hs.spotlight:start](#start). At present, starting a query is the only way to fully guarantee that a query is in a valid format.
--
--  * Some of the query strings which have been used during the testing of this module are as follows (note that [[ ]] is a Lua string specifier that allows for double quotes in the content of the string):
--    * [[ kMDItemContentType == "com.apple.application-bundle" ]]
--    * [[ kMDItemFSName like "*Explore*" ]]
--    * [[ kMDItemFSName like "AppleScript Editor.app" or kMDItemAlternateNames like "AppleScript Editor"]]
--
--  * Not all attributes appear to be usable in a query; see `hs.spotlight.item:attributes` for a possible explanation.
--
--  * As a convenience, the __call metamethod has been setup for spotlightObject so that you can use `spotlightObject("query")` as a shortcut for `spotlightObject:queryString("query"):start`.  Because this shortcut includes an explicit start, this should be appended after you have set the callback function if you require a callback (e.g. `spotlightObject:setCallback(fn)("query")`).
function M:queryString(query, ...) end

-- Returns the spotlightItemObject at the specified index of the spotlightObject
--
-- Parameters:
--  * `index` - an integer specifying the index of the result to return.
--
-- Returns:
--  * the spotlightItemObject at the specified index or an error if the index is out of bounds.
--
-- Notes:
--  * For convenience, metamethods have been added to the spotlightObject which allow you to use `spotlightObject[index]` as a shortcut for `spotlightObject:resultAtIndex(index)`.
function M:resultAtIndex(index, ...) end

-- Get or set the search scopes allowed for the Spotlight query.
--
-- Parameters:
--  * `scope` - an optional table or list of items specifying the search scope for the Spotlight query.  Defaults to an empty array, specifying that the search is not limited in scope.
--
-- Returns:
--  * if an argument is provided for `scope`, returns the spotlightObject; otherwise returns a table containing the current search scopes.
--
-- Notes:
--  * Setting this property while a query is running stops the query and discards the current results. The receiver immediately starts a new query.
--
--  * Each item listed in the `scope` table may be a string or a file URL table as described in documentation for the `hs.sharing.URL` and `hs.sharing.fileURL` functions.
--    * if an item is a string and matches one of the values in the [hs.spotlight.definedSearchScopes](#definedSearchScopes) table, then the scope for that item will be added to the valid search scopes.
--    * if an item is a string and does not match one of the predefined values, it is treated as a path on the local system and will undergo tilde prefix expansion befor being added to the search scopes (i.e. "~/" will be expanded to "/Users/username/").
--    * if an item is a table, it will be treated as a file URL table.
function M:searchScopes(scope, ...) end

-- Set or remove the callback function for the Spotlight search object.
--
-- Parameters:
--  * `fn` - the function to replace the current callback function.  If this argument is an explicit nil, removes the current callback function and does not replace it.  The function should expect 2 or 3 arguments and should return none.
--
-- Returns:
--  * the spotlightObject
--
-- Notes:
--  * Depending upon the messages set with the [hs.spotlight:callbackMessages](#callbackMessages) method, the following callbacks may occur:
--
--    * obj, "didStart" -- occurs when the initial gathering phase of a Spotlight search begins.
--      * `obj`     - the spotlightObject performing the search
--      * `message` - the message to the callback, in this case "didStart"
--
--    * obj, "inProgress", updateTable -- occurs during the initial gathering phase at intervals set by the [hs.spotlight:updateInterval](#updateInterval) method.
--      * `obj`         - the spotlightObject performing the search
--      * `message`     - the message to the callback, in this case "inProgress"
--      * `updateTable` - a table containing one or more of the following keys:
--        * `kMDQueryUpdateAddedItems`   - an array table of spotlightItem objects that have been added to the results
--        * `kMDQueryUpdateChangedItems` - an array table of spotlightItem objects that have changed since they were first added to the results
--        * `kMDQueryUpdateRemovedItems` - an array table of spotlightItem objects that have been removed since they were first added to the results
--
--    * obj, "didFinish" -- occurs when the initial gathering phase of a Spotlight search completes.
--      * `obj`     - the spotlightObject performing the search
--      * `message` - the message to the callback, in this case "didFinish"
--
--    * obj, "didUpdate", updateTable -- occurs after the initial gathering phase has completed. This indicates that a change has occurred after the initial query that affects the result set.
--      * `obj`         - the spotlightObject performing the search
--      * `message`     - the message to the callback, in this case "didUpdate"
--      * `updateTable` - a table containing one or more of the keys described for the `updateTable` argument of the "inProgress" message.
--
--  * All of the results are always available through the [hs.spotlight:resultAtIndex](#resultAtIndex) method and metamethod shortcuts described in the `hs.spotlight` and `hs.spotlight.item` documentation headers; the results provided by the "didUpdate" and "inProgress" messages are just a convenience and can be used if you wish to parse partial results.
function M:setCallback(fn_or_nil, ...) end

-- Get or set the sorting preferences for the results of a Spotlight query.
--
-- Parameters:
--  * `attributes` - an optional table or list of items specifying sort descriptors which affect the sorting order of results for a Spotlight query.  Defaults to an empty array.
--
-- Returns:
--  * if an argument is provided, returns the spotlightObject; otherwise returns the current values
--
-- Notes:
--  * Setting this property while a query is running stops the query and discards the current results. The receiver immediately starts a new query.
--
--  * A sort descriptor may be specified as a string or as a table of key-value pairs.  In the case of a string, the sort descriptor will sort items in an ascending manner.  When specified as a table, at least the following keys should be specified:
--    * `key`       - a string specifying the attribute to sort by
--    * `ascending` - a boolean, default true, specifying whether the sort order should be ascending (true) or descending (false).
--
--  * This method attempts to specify the sorting order of the results returned by the Spotlight query.
--  * Note that not all attributes can be used as an attribute in a sort descriptor.  In such cases, the sort descriptor will have no affect on the order of returned items.
function M:sortDescriptors(attributes, ...) end

-- Begin the gathering phase of a Spotlight query.
--
-- Parameters:
--  * None
--
-- Returns:
--  * the spotlightObject
--
-- Notes:
--  * If the query string set with [hs.spotlight:queryString](#queryString) is invalid, an error message will be logged to the Hammerspoon console and the query will not start.  You can test to see if the query is actually running with the [hs.spotlight:isRunning](#isRunning) method.
function M:start() end

-- Stop the Spotlight query.
--
-- Parameters:
--  * None
--
-- Returns:
--  * the spotlightObject
--
-- Notes:
--  * This method will prevent further gathering of items either during the initial gathering phase or from updates which may occur after the gathering phase; however it will not discard the results already discovered.
function M:stop() end

-- Get or set the time interval at which the spotlightObject will send "didUpdate" messages during the initial gathering phase.
--
-- Parameters:
--  * `interval` - an optional number, default 1.0, specifying how often in seconds the "didUpdate" message should be generated during the initial gathering phase of a Spotlight query.
--
-- Returns:
--  * if an argument is provided, returns the spotlightObject object; otherwise returns the current value.
function M:updateInterval(interval, ...) end

-- Get or set the attributes for which value list summaries are produced for the Spotlight query.
--
-- Parameters:
--  * `attributes` - an optional table or list of items specifying the attributes for which value list summaries are produced for the Spotlight query.  Defaults to an empty array.
--
-- Returns:
--  * if an argument is provided, returns the spotlightObject; otherwise returns the current values
--
-- Notes:
--  * Setting this property while a query is running stops the query and discards the current results. The receiver immediately starts a new query.
--  * Setting this property will increase CPU and memory usage while performing the Spotlight query.
--
--  * This method allows you to specify attributes for which you wish to gather summary information about.  See [hs.spotlight:valueLists](#valueLists) for more information about value list summaries.
--  * Note that not all attributes can be used as a value list attribute.  In such cases, the summary for the attribute will specify all results and an attribute value of nil.
function M:valueListAttributes(attributes, ...) end

-- Returns the value list summaries for the Spotlight query
--
-- Parameters:
--  * None
--
-- Returns:
--  * an array table of the value list summaries for the Spotlight query as specified by the [hs.spotlight:valueListAttributes](#valueListAttributes) method.  Each member of the array will be a table with the following keys:
--    * `attribute` - the attribute for the summary
--    * `value`     - the value of the attribute for the summary
--    * `count`     - the number of Spotlight items in the spotlightObject results for which this attribute has this value
--
-- Notes:
--  * Value list summaries are a quick way to gather statistics about the number of results which match certain criteria - they do not allow you easy access to the matching members, just information about their numbers.
function M:valueLists() end

