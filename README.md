# EmployeesApp

# Scope
Employees App is a simple app that fetches a list of employees from a un-authorized 
endpoint and shows the results in a TableView. 

The scode was reduced to iPhones and the device orientation as Portrait

# UI
The UI was built programmatically with UIKit. 

# Architecture:
MVVM 


Important classes:
1. AppFactoryContainer
    It is the object factory of the app, it helps instanctiating
    ViewControllers, Services, etc. It also stores of global services or variables if they need to be persisted when the app
    is running. 

    One usage example is when presenting a new view controller, the 
    AppFactoryContainer can be called like the following:
    ```
        let newViewController = AppFactoryContainer.makeViewController()
        self.present(newViewController)
    ``` 
    So the `makeViewController` will create the the new View Controller while injecting all of its depedencies. 


1. HomeViewController 
    This is the main and only view controller of this app. 

    Important properties:
    * `mainView`: it is a view object that contains all the elements of the ui. 
    *  `viewModel`
    *  `model`: data of the tableView
    
2. HomeViewModel
    It consumes the corresponding newtorking services to fetch
    the data from servers whenever is required, plus it is binded
    to the UI to show the changes of data. 

3. RemoteAPIEmployeeService
    It is a service that uses the `GenericNetworkService` under the hood and it fetches the list of employee from the servers.
4. ImageCacheService: 
    It is a service that deals with the image caching.
4. RemoteImageFetcherService
    It is a service that helps downloading images. 
3. GenericNetworkService
    It is a static class that has some methods with generic parameters that it is being used to request data from servers. 


## HomeViewModel 
MainViewModel



# Dependency graph:

Here it goes


# 