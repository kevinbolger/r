# R FitBit Package

A package with a set of functions to pull sensor data from FitBit.

See: https://www.dataquest.io/blog/python-api-tutorial/ for great tutorial on API's work.

Status codes
The request we just made had a status code of 200. Status codes are returned with every request that is made to a web server. Status codes indicate information about what happened with a request. Here are some codes that are relevant to GET requests:

200 -- everything went okay, and the result has been returned (if any)
301 -- the server is redirecting you to a different endpoint. This can happen when a company switches domain names, or an endpoint name is changed.
401 -- the server thinks you're not authenticated. This happens when you don't send the right credentials to access an API (we'll talk about authentication in a later post).
400 -- the server thinks you made a bad request. This can happen when you don't send along the right data, among other things.
403 -- the resource you're trying to access is forbidden -- you don't have the right permissions to see it.
404 -- the resource you tried to access wasn't found on the server.
