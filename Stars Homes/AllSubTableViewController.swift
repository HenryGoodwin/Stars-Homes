//
//  AllSubTableViewController.swift
//  Stars Homes
//
//  Created by Henry Goodwin on 25/01/2016.
//  Copyright © 2016 Henry Goodwin. All rights reserved.
//

import UIKit
import iAd

class AllSubTableViewController: UITableViewController, ADBannerViewDelegate {
    
    @IBOutlet var adBannerView: ADBannerView?


    // MARK: - Properties
    var detailViewController: DetailViewController? = nil
    var House = [Home]()
    var filteredHouse = [Home]()
    let searchController = UISearchController(searchResultsController: nil)
    
    struct Objects {
        var sectionName: String!
        var sectionObjects: [String]!
    }
    
    var objectsArray = [Objects]()
    
    
    // MARK: - View Setup
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.canDisplayBannerAds = true
        self.adBannerView?.delegate = self
        self.adBannerView?.hidden = true
        
        // Setup the Search Controller
        searchController.searchResultsUpdater = self
        searchController.searchBar.delegate = self
        definesPresentationContext = true
        searchController.dimsBackgroundDuringPresentation = false
        searchController.searchBar.placeholder = "Search For A Star"
        
        searchController.searchBar.scopeButtonTitles = ["All", "Film & TV", "Music", "Sport","Iconic", "Other"]
        
        tableView.tableHeaderView = searchController.searchBar
        
        House = [
            
            Home(category:"Other", name:"Christian Audigier", URL: "https://en.wikipedia.org/wiki/Christian_Audigier", pinLatitude: 34.063654 , pinLongitude : -118.329737, pinDetail : "600 S Muirfield Rd, Beverly Hills", pinTitle: "Christian Audigier"),
            
            Home(category:"Film & TV", name:"Hank Azaria", URL: "https://en.wikipedia.org/wiki/Hank_Azaria", pinLatitude: 34.110087 , pinLongitude : -118.418868, pinDetail : "2120 N Beverly Dr, Beverly Hills", pinTitle: "Hank Azaria"),
            
            Home(category:"Film & TV", name:"Mischa Barton", URL: "https://en.wikipedia.org/wiki/Mischa_Barton", pinLatitude: 34.117475, pinLongitude : -118.398497 , pinDetail : "2670 Bowmont Dr, Beverly Hills", pinTitle: "Mischa Barton"),
            
            Home(category:"Film & TV", name:"Jason Bateman", URL: "https://en.wikipedia.org/wiki/Jason_Bateman", pinLatitude: 34.113902 , pinLongitude : -118.387308, pinDetail : "8828 Wonderland Park Ave, Hollywood Hills", pinTitle: "Jason Bateman"),
            
            Home(category:"Film & TV", name:"Michael Bay", URL: "https://en.wikipedia.org/wiki/Michael_Bay", pinLatitude: 34.086352, pinLongitude : -118.451039 , pinDetail : "900 Stradella Rd, Bel Air", pinTitle: "Michael Bay"),
            
            Home(category:"Film & TV", name:"Jack Black", URL: "https://en.wikipedia.org/wiki/Jack_Black", pinLatitude: 34.117854 , pinLongitude :  -118.382431, pinDetail : "8538 Eastwood Rd, Hollywood Hills", pinTitle: "Jack Black"),
            
            Home(category:"Film & TV", name:"Orlando Bloom", URL: "https://en.wikipedia.org/wiki/Orlando_Bloom", pinLatitude: 34.116248, pinLongitude :  -118.348198 , pinDetail : "2645 Outpost Dr, Hollywood Hills", pinTitle: "Orlando Bloom"),
            
            Home(category:"Sport", name:"Barry Bonds", URL: "https://en.wikipedia.org/wiki/Barry_Bonds", pinLatitude: 34.116698, pinLongitude : -118.417763 , pinDetail : "44 Beverly Park Cir, Beverly Hills", pinTitle: "Barry Bonds"),
            
            Home(category:"Film & TV", name:"Kate Bosworth", URL: "https://en.wikipedia.org/wiki/Kate_Bosworth", pinLatitude: 34.118633 , pinLongitude :  -118.356116, pinDetail : "2633 La Cuesta Dr, Hollywood Hills", pinTitle: "Kate Bosworth"),
            
            Home(category:"Music", name:"Toni Braxton", URL: "https://en.wikipedia.org/wiki/Toni_Braxton", pinLatitude: 34.132097 , pinLongitude : -118.669100, pinDetail : "25281 Prado Del Grandioso, Calabasas", pinTitle: "Toni Braxton"),
            
            Home(category:"Sport", name:"Reggie Bush", URL: "https://en.wikipedia.org/wiki/Reggie_Bush", pinLatitude: 34.098247 , pinLongitude : -118.382715, pinDetail : "1501 Viewsite Ter, Hollywood Hills", pinTitle: "Reggie Bush"),
            
            Home(category:"Film & TV", name:"Nicolas Cage", URL: "https://en.wikipedia.org/wiki/Nicolas_Cage", pinLatitude : 34.0824042, pinLongitude : -118.4407743, pinDetail : "363 Copa De Oro Road, Bel Air", pinTitle: "Nicholas Cage"),
            
            Home(category:"Film & TV", name:"Nick Cannon", URL: "https://en.wikipedia.org/wiki/Nick_Cannon", pinLatitude: 34.129341 , pinLongitude : -118.463620, pinDetail : "3130 Antelo Rd, Bel Air", pinTitle: "Nick Cannon"),
            
            Home(category:"Music", name:"Mariah Carey", URL: "https://en.wikipedia.org/wiki/Mariah_Carey", pinLatitude: 34.129341 , pinLongitude : -118.463620, pinDetail : "3130 Antelo Rd, Bel Air", pinTitle: "Mariah Carey"),
            
            Home(category:"Film & TV", name:"Bill Cosby", URL: "https://en.wikipedia.org/wiki/Bill_Cosby", pinLatitude: 34.057390 , pinLongitude : -118.503264, pinDetail : "1500 Sorrento Dr, Pacific Palisades", pinTitle: "Bill Cosby"),
            
            Home(category:"Film & TV", name:"Kaley Cuoco", URL: "https://en.wikipedia.org/wiki/Kaley_Cuoco", pinLatitude: 34.148293 , pinLongitude : -118.454634, pinDetail : "14717 Sutton St, Sherman Oaks", pinTitle: "Kaley Cuoco"),
            
            Home(category:"Film & TV", name:"Simon Cowell", URL: "https://en.wikipedia.org/wiki/Simon_Cowell", pinLatitude: 34.093171, pinLongitude : -118.399626, pinDetail : "917 Loma Vista Dr, Beverly Hills", pinTitle: "Simon Cowell"),
            
            Home(category:"Film & TV", name:"Leonardo DiCaprio", URL: "https://en.wikipedia.org/wiki/Leonardo_DiCaprio", pinLatitude: 33.835863 , pinLongitude : -116.551825, pinDetail : "432 Hermosa Pl, Palm Springs", pinTitle: "Leonardo DiCaprio"),
            
            
            Home(category:"Film & TV", name:"Taye Diggs", URL: "https://en.wikipedia.org/wiki/Taye_Diggs", pinLatitude: 34.126091 , pinLongitude : -118.390604, pinDetail : "3121 Oakdell Ln, Studio City", pinTitle: "Taye Diggs"),
            
            Home(category:"Film & TV", name:"Walt Disney", URL: "https://en.wikipedia.org/wiki/Walt_Disney", pinLatitude: 34.084795 , pinLongitude : -118.429003, pinDetail : "355 Carolwood Drive, Beverly Hills", pinTitle: "Walt Disney (1901 - 1966)"),
            
            Home(category:"Music", name:"Dr. Dre", URL: "https://en.wikipedia.org/wiki/Dr._Dre", pinLatitude: 34.095974 , pinLongitude : -118.389796, pinDetail : "9161 Oriole Way, Hollwood Hills", pinTitle: "Dr. Dre"),
            
            Home(category:"Film & TV", name:"Michael Clarke Duncan", URL: "https://en.wikipedia.org/wiki/Michael_Clarke_Duncan", pinLatitude: 34.172592 , pinLongitude : -118.609883, pinDetail : "5616 Farralone Ave, Woodland Hills", pinTitle: "Michael Clarke Duncan"),
            
            Home(category:"Music", name:"Bob Dylan", URL: "https://en.wikipedia.org/wiki/Bob_Dylan", pinLatitude: 34.009805, pinLongitude : -118.811177, pinDetail : "29400 Bluewater Road, Malibu", pinTitle: "Bob Dylan"),
            
             Home(category:"Film & TV", name:"Zac Efron", URL: "https://en.wikipedia.org/wiki/Zac_Efron", pinLatitude: 34.122490 , pinLongitude : -118.367484, pinDetail : "7861 Woodrow Wilson Dr, Hollwood Hills", pinTitle: "Zac Efron"),
            
            Home(category:"Film & TV", name:"Clint Eastwood", URL: "https://en.wikipedia.org/wiki/Clint_Eastwood", pinLatitude :34.084666, pinLongitude : -118.452541, pinDetail : "846 Stradella Road, Bel Air", pinTitle: "Clint Eastwood"),
            
            Home(category:"Iconic", name:"Modern Family Cam & Mitch", URL: "https://en.wikipedia.org/wiki/Modern_Family", pinLatitude: 34.051841 , pinLongitude : -118.416272, pinDetail : "2211 Fox Hills Dr, Beverly Hills", pinTitle: "Modern Family Cam & Mitch"),
            
            Home(category:"Iconic", name:"Modern Family Jay & Gloria", URL: "https://en.wikipedia.org/wiki/Modern_Family", pinLatitude: 34.059955 , pinLongitude :  -118.489400, pinDetail : "251 N Bristol Ave, Brentwood", pinTitle: "Modern Family Jay & Gloria"),
            
            Home(category:"Iconic", name:"Modern Family Phil & Claire", URL: "https://en.wikipedia.org/wiki/Modern_Family", pinLatitude: 34.036356 , pinLongitude : -118.410230, pinDetail : "10336 Dunleer Dr, Beverly Hills", pinTitle: "Modern Family Phil & Claire"),
            
            Home(category:"Film & TV", name:"Craig Ferguson", URL: "https://en.wikipedia.org/wiki/Craig_Ferguson", pinLatitude: 34.113177, pinLongitude : -118.323612 , pinDetail : "6248 Winans Dr, Hollywood Hills", pinTitle: "Craig Ferguson"),
            
            Home(category:"Film & TV", name:"Jesse Tyler Ferguson", URL: "https://en.wikipedia.org/wiki/Jesse_Tyler_Ferguson", pinLatitude: 34.117374, pinLongitude : -118.288129 , pinDetail : "2566 Aberdeen Ave, Los Feliz", pinTitle: "Jesse Tyler Ferguson"),
            
            
            Home(category:"Film & TV", name:"Jenna Fischer", URL: "https://en.wikipedia.org/wiki/Jenna_Fischer", pinLatitude: 34.138209, pinLongitude :-118.410849, pinDetail : "3774 Alta Mesa Dr, Studio City", pinTitle: "Jenna Fischer"),
            
            Home(category:"Film & TV", name:"Yolanda Foster", URL: "https://en.wikipedia.org/wiki/Yolanda_Hadid", pinLatitude: 34.038773, pinLongitude : -118.650812, pinDetail : "3905 Carbon Canyon Rd, Malibu", pinTitle: "Yolanda Foster"),
            
            Home(category:"Music", name:"John Fogerty", URL: "https://en.wikipedia.org/wiki/John_Fogerty", pinLatitude: 34.119185 , pinLongitude : -118.426535, pinDetail : "9754 Oak Pass Rd, Beverly Hills", pinTitle: "John Fogerty"),
            
            Home(category:"Film & TV", name:"Jodie Foster", URL: "https://en.wikipedia.org/wiki/Jodie_Foster", pinLatitude: 34.097658, pinLongitude : -118.391320 , pinDetail : " 9219 Flicker Way, Hollywood Hills", pinTitle: "Jodie Foster"),
            
            Home(category:"Film & TV", name:"Harrison Ford", URL: "https://en.wikipedia.org/wiki/Harrison_Ford", pinLatitude: 34.096974 , pinLongitude : -118.420953, pinDetail : "1420 Braeridge Drive, Beverly Hills", pinTitle: "Harrison Ford"),
            
            Home(category:"Film & TV", name:"Megan Fox", URL: "https://en.wikipedia.org/wiki/Megan_Fox", pinLatitude: 34.114836 , pinLongitude :  -118.296151, pinDetail : "2771 Glendower Ave, Los Feliz", pinTitle: "Brian Austin Green & Megan Fox’s House"),
            
            Home(category:"Film & TV", name:"Jeff Franklin", URL: "https://en.wikipedia.org/wiki/Jeff_Franklin", pinLatitude: 34.094353 , pinLongitude : -118.383226, pinDetail : "1302 Collingwood Place, Beverly Hills", pinTitle: "Jeff Franklin"),
            
            
            
            Home(category:"Film & TV", name:"Brian Austin Green", URL: "hhttps://en.wikipedia.org/wiki/Brian_Austin_Green", pinLatitude: 34.114836 , pinLongitude :  -118.296151, pinDetail : "2771 Glendower Ave, Los Feliz", pinTitle: "Brian Austin Green & Megan Fox’s House"),
            
            Home(category:"Film & TV", name:"Jake Gyllenhaal", URL: "https://en.wikipedia.org/wiki/Jake_Gyllenhaal", pinLatitude: 34.124929, pinLongitude :  -118.355291, pinDetail : "17411 Woodrow Wilson Dr, Hollywood Hills", pinTitle: "Jake Gyllenhaal"),
            
            Home(category:"Film & TV", name:"Michael C. Hall", URL: "https://en.wikipedia.org/wiki/Michael_C._Hall", pinLatitude: 34.108934, pinLongitude : -118.327782 , pinDetail : "2092 Mound St, Hollywood Hills", pinTitle: "Michael C. Hall"),
            
            Home(category:"Film & TV", name:"Tom Hanks", URL: "https://en.wikipedia.org/wiki/Tom_Hanks", pinLatitude: 34.031287 , pinLongitude : -118.684904, pinDetail : "23414 Malibu Colony Dr, Malibu", pinTitle: "Tom Hanks"),
            
            Home(category:"Film & TV", name:"Chris Hemsworth", URL: "https://en.wikipedia.org/wiki/Chris_Hemsworth", pinLatitude: 34.010446, pinLongitude :  -118.803201 , pinDetail : "7022 Grasswood Ave, Malibu", pinTitle: "Chris Hemsworth"),

            
            Home(category:"Other", name:"Bob Hope", URL: "https://en.wikipedia.org/wiki/Bob_Hope", pinLatitude: 33.787345, pinLongitude :  -116.511544 , pinDetail : "2466 Southridge Dr, Palm Springs", pinTitle: "Bob Hope (1903-2003)"),
        
            Home(category:"Music", name:"Michael Jackson", URL: "https://en.wikipedia.org/wiki/Michael_Jackson", pinLatitude : 34.080663, pinLongitude : -118.426146, pinDetail : "100 N. Carolwood Drive, Bel Air, Michael Jackson's Last Home", pinTitle: "Michael Jackson (1958-2009)"),
        
            Home(category:"Music", name:"Michael Jackson's Neverland Ranch", URL: "https://en.wikipedia.org/wiki/Neverland_Ranch", pinLatitude: 34.741603 , pinLongitude :  -120.092954, pinDetail : "5225 Figueroa Mountain Rd, Los Olivos", pinTitle: "Michael Jackson's Neverland Ranch"),
            
            Home(category:"Music", name:"The Jackson Family Home", URL: "https://en.wikipedia.org/wiki/The_Jackson_5"  , pinLatitude: 34.1547155 , pinLongitude : -118.492348, pinDetail : "4641 Hayvenhurst Ave, Encino, Home Of The Jackson 5", pinTitle: "The Jackson Family Home"),
            
            Home(category:"Film & TV", name:"Joshua Jackson", URL: "https://en.wikipedia.org/wiki/Joshua_Jackson", pinLatitude: 34.111456, pinLongitude :  -118.327681 , pinDetail : "6342 Ivarene Ave, Hollywood Hills", pinTitle: "Joshua Jackson"),
            
            Home(category:"Film & TV", name:"Samuel L. Jackson",URL: "https://en.wikipedia.org/wiki/Samuel_L._Jackson", pinLatitude: 34.1646368 , pinLongitude : -118.5141974, pinDetail : "5128 Encino Ave, Encino", pinTitle: "Samuel L. Jackson"),
            
            
            Home(category:"Film & TV", name:"Khloe Kardashian",URL: "https://en.wikipedia.org/wiki/Khlo%C3%A9_Kardashian", pinLatitude: 34.128589 , pinLongitude : -118.671428, pinDetail : "25202 Prado Del Grandioso, Calabasas", pinTitle: "Khloe Kardashian"),
            
            Home(category:"Film & TV", name:"Kourtney Kardashian", URL: "https://en.wikipedia.org/wiki/Kourtney_Kardashian", pinLatitude: 34.127899, pinLongitude : -118.676961 , pinDetail : "25344 Prado De La Felicidad, Calabasas", pinTitle: "Kourtney Kardashian"),
            
            Home(category:"Film & TV", name:"Chris Kattan", URL: "https://en.wikipedia.org/wiki/Chris_Kattan", pinLatitude: 34.103090, pinLongitude : -118.357158 , pinDetail : "1746 Courtney Ave, Hollwood Hills", pinTitle: "Chris Kattan"),
            
            Home(category:"Other", name:"Jamie Kennedy", URL: "https://en.wikipedia.org/wiki/Jamie_Kennedy", pinLatitude: 34.115899, pinLongitude :  -118.289968 , pinDetail : "2508 N Vermont Ave, Los Feliz", pinTitle: "Jamie Kennedy"),
            
            Home(category:"Film & TV", name:"Diane Kruger", URL: "https://en.wikipedia.org/wiki/Diane_Kruger", pinLatitude: 34.111456, pinLongitude :  -118.327681 , pinDetail : "6342 Ivarene Ave, Hollywood Hills", pinTitle: "Diane Kruger"),
            
            Home(category:"Music", name:"John Legend",URL: "https://en.wikipedia.org/wiki/John_Legend", pinLatitude: 34.124322 , pinLongitude : -118.339005, pinDetail : "3023 Longdale Ln, Hollywood Hills", pinTitle: "John Legend"),
            
            Home(category:"Film & TV", name:"Justin Long",URL: "https://en.wikipedia.org/wiki/Justin_Long", pinLatitude: 34.110926 , pinLongitude :  -118.313095, pinDetail : "5682 Holly Oak Dr, Hollywood Hills", pinTitle: "Justin Long"),
            
            Home(category:"Film & TV", name:"Jennifer Lopez",URL: "https://en.wikipedia.org/wiki/Jennifer_Lopez", pinLatitude: 34.159033 , pinLongitude : -118.668873, pinDetail : "25067 Jim Bridger Rd, Hidden Hills", pinTitle: "Jennifer Lopez"),
            
            Home(category:"Music", name:"Madonna", URL: "https://en.wikipedia.org/wiki/Madonna_(entertainer)", pinLatitude: 34.0872054 , pinLongitude : -118.3994811, pinDetail : "9425 Sunset Blvd, Beverly Hills", pinTitle: "Madonna"),
        
            Home(category:"Film & TV", name:"Eddie Murphy", URL: "https://en.wikipedia.org/wiki/Eddie_Murphy", pinLatitude: 34.0991198 , pinLongitude : -118.3969917, pinDetail : "1081 Wallace Ridge, Beverly Hills", pinTitle: "Eddie Murphy"),
        
            //Elvis Presley
            Home(category:"Music", name:"Elvis Presley", URL: "https://en.wikipedia.org/wiki/Elvis_Presley", pinLatitude: 34.097919 , pinLongitude : -118.3969712, pinDetail : "Elvis lived here from November 1967 until sometime in 1970", pinTitle: "Elvis Presley (1935-1977)"),
            
            Home(category:"Film & TV", name:"Leighton Meester", URL: "https://en.wikipedia.org/wiki/Leighton_Meester", pinLatitude: 34.149980 , pinLongitude : -118.477468 , pinDetail : "15740 Woodvale Rd, Encino", pinTitle: "Steve Martin"),
            
            Home(category:"Film & TV", name:"Christopher Meloni", URL: "https://en.wikipedia.org/wiki/Christopher_Meloni", pinLatitude: 34.104265 , pinLongitude : -118.349960 , pinDetail : "1822 Camino Palmero St, Hollywood Hills", pinTitle: "Christopher Meloni"),
            
            Home(category:"Music", name:"Brian Malouf", URL: "https://en.wikipedia.org/wiki/Brian_Malouf", pinLatitude: 34.161440 , pinLongitude : -118.421838 , pinDetail : "13245 Addison St, Sherman Oaks", pinTitle: "Brian Malouf"),
            
            Home(category:"Film & TV", name:"Howie Mandel", URL: "https://en.wikipedia.org/wiki/Howie_Mandel", pinLatitude: 34.011605, pinLongitude : -118.805946 , pinDetail : "6950 Dume Dr, Malibu", pinTitle: "Howie Mandel"),
            
            Home(category:"Film & TV", name:"Mike Medavoy", URL: "https://en.wikipedia.org/wiki/Mike_Medavoy", pinLatitude: 34.082750 , pinLongitude :  -118.445913 , pinDetail : "638 Siena Way, Bel Air", pinTitle: "Mike Medavoy"),
            
            Home(category:"Film & TV", name:"Marilyn Monroe", URL: "https://en.wikipedia.org/wiki/Marilyn_Monroe", pinLatitude: 34.078282 , pinLongitude :  -118.396156 , pinDetail : "508 N. Palm Drive, Beverly Hills", pinTitle: "Marilyn Monroe"),
        
        
            Home(category:"Music", name:"Chris Martin", URL: "https://en.wikipedia.org/wiki/Chris_Martin", pinLatitude: 34.011088 , pinLongitude : -118.795864 , pinDetail : "28815 Grayfox St, Malibu", pinTitle: "Chris Martin"),
        
            Home(category:"Film & TV", name:"Eva Mendes", URL: "https://en.wikipedia.org/wiki/Eva_Mendes", pinLatitude: 34.116675 , pinLongitude : -118.318562 , pinDetail : "2732 Hollyridge Dr, Hollywood Hills", pinTitle: "Eva Mendes"),
            
            Home(category:"Film & TV", name:"Nick Nolte", URL: "https://en.wikipedia.org/wiki/Nick_Nolte", pinLatitude: 34.022249, pinLongitude : -118.814860 , pinDetail : "6173 Bonsall Dr, Malibu", pinTitle: "Nick Nolte"),
        
            Home(category:"Other", name:"Jack Osbourne", URL: "https://en.wikipedia.org/wiki/Jack_Osbourne", pinLatitude: 34.111421, pinLongitude : -118.294152 , pinDetail : "2220 N Berendo St, Los Feliz", pinTitle: "Jack Osbourne"),
        
            Home(category:"Music", name:"Kelly Osbourne", URL: "https://en.wikipedia.org/wiki/Kelly_Osbourne", pinLatitude: 34.099357, pinLongitude : -118.369727 , pinDetail : "8281 Hollywood Blvd, Hollywood Hills", pinTitle: "Kelly Osbourne"),
            
            Home(category:"Film & TV", name:"Ellen Page", URL: "https://en.wikipedia.org/wiki/Ellen_Page", pinLatitude: 34.133971, pinLongitude : -118.379282 , pinDetail : "11283 Canton Dr, Studio City", pinTitle: "Ellen Page"),
            
            Home(category:"Film & TV", name:"Gwyneth Paltrow", URL: "https://en.wikipedia.org/wiki/Gwyneth_Paltrow", pinLatitude: 34.011087 , pinLongitude :-118.795838, pinDetail : "28815 Grayfox St, Malibu", pinTitle: "Gwyneth Paltrow"),
            
            Home(category:"Film & TV", name:"Robert Pattinson", URL: "https://en.wikipedia.org/wiki/Robert_Pattinson", pinLatitude: 34.111464, pinLongitude : -118.327691 , pinDetail : "6342 Ivarene Ave, Hollywood Hills", pinTitle: "Robert Pattinson"),
            
            Home(category:"Film & TV", name:"Mario Van Peebles", URL: "https://en.wikipedia.org/wiki/Mario_Van_Peebles", pinLatitude: 34.124877, pinLongitude : -118.351144 , pinDetail : "3094 Ellington Dr, Hollywood Hills", pinTitle: "Mario Van Peebles"),
        
            Home(category:"Other", name:"Markus Persson", URL: "https://en.wikipedia.org/wiki/Markus_Persson", pinLatitude: 34.097244, pinLongitude :  -118.394545 , pinDetail : "1181 N Hillcrest Rd, Beverly Hills", pinTitle: "Markus Persson"),
            
            Home(category:"Music", name:"Katy Perry", URL: "https://en.wikipedia.org/wiki/Katy_Perry", pinLatitude: 34.100882, pinLongitude : -118.366233 , pinDetail : "8159 Hollywood Blvd, Hollywood Hills", pinTitle: "Katy Perry"),
        
            Home(category:"Film & TV", name:"Matthew Perry", URL: "https://en.wikipedia.org/wiki/Matthew_Perry", pinLatitude: 34.038513, pinLongitude : -118.676996 , pinDetail : "3556 Sweetwater Mesa Rd, Malibu", pinTitle: "Matthew Perry"),
        
            Home(category:"Music", name:"Pink", URL: "https://en.wikipedia.org/wiki/Pink_(singer)", pinLatitude: 34.147459, pinLongitude : -118.455430 , pinDetail : "14734 Sutton St, Sherman Oaks", pinTitle: "Pink"),
        
            Home(category:"Iconic", name:"Fresh Prince of Bel Air Mansion", URL: "https://en.wikipedia.org/wiki/The_Fresh_Prince_of_Bel-Air", pinLatitude: 34.086673, pinLongitude : -118.436948 , pinDetail : "616 Nimes Rd, Bel Air", pinTitle: "Fresh Prince of Bel Air Mansion"),
        
            Home(category:"Film & TV", name:"Jeremy Renner", URL: "https://en.wikipedia.org/wiki/Jeremy_Renner", pinLatitude: 34.103100, pinLongitude :  -118.351675 , pinDetail : "7420 Franklin Ave, Hollywood Hills", pinTitle: "Jeremy Renner"),
            
            Home(category:"Film & TV", name:"Ryan Reynolds", URL: "https://en.wikipedia.org/wiki/Ryan_Reynolds", pinLatitude: 34.114687, pinLongitude : -118.345763 , pinDetail : " 2416 Carman Crest Dr, Hollywood Hills", pinTitle: "Ryan Reynolds"),
            
            Home(category:"Film & TV", name:"Christina Ricci", URL: "https://en.wikipedia.org/wiki/Christina_Ricci", pinLatitude: 34.112467, pinLongitude : -118.308437 , pinDetail : "5417 Red Oak Dr, Hollywood Hills", pinTitle: "Christina Ricci"),
            
            Home(category:"Other", name:"Nicole Richie", URL: "https://en.wikipedia.org/wiki/Nicole_Richie", pinLatitude: 34.170553 , pinLongitude : -118.268032, pinDetail : "1516 Hillcrest Ave, Glendale", pinTitle: "Nicole Richie"),
            
            Home(category:"Music", name:"Kid Rock", URL: "https://en.wikipedia.org/wiki/Kid_Rock", pinLatitude: 34.009497, pinLongitude : -118.798325 , pinDetail : "28830 Bison Ct, Malibu", pinTitle: "Kid Rock"),
            
            Home(category:"Music", name:"Kenny Rogers", URL: "https://en.wikipedia.org/wiki/Kenny_Rogers", pinLatitude: 34.086709, pinLongitude : -118.437071 , pinDetail : "616 Nimes Rd, Bel Air", pinTitle: "Kenny Rogers"),
            
            Home(category:"Sport", name:"Pete Rose", URL: "https://en.wikipedia.org/wiki/Pete_Rose", pinLatitude: 34.168034, pinLongitude :  -118.424271 , pinDetail : "13348 Chandler Blvd, Sherman Oaks", pinTitle: "Pete Rose"),
            
            Home(category:"Film & TV", name:"Eva Marie Saint", URL: "https://en.wikipedia.org/wiki/Eva_Marie_Saint", pinLatitude: 34.081338 , pinLongitude : -118.501082 , pinDetail : "2410 Mandeville Canyon Rd, Brentwood", pinTitle: "Eva Marie Saint"),
            
            Home(category:"Film & TV", name:"Zoe Saldana", URL: "https://en.wikipedia.org/wiki/Zoe_Saldana", pinLatitude: 34.105964, pinLongitude : -118.278210 , pinDetail : "2320 St George St, Los Feliz", pinTitle: "Zoe Saldana"),
        
            Home(category:"Sport", name:"Pete Sampras", URL: "https://en.wikipedia.org/wiki/Pete_Sampras", pinLatitude: 34.128548, pinLongitude :  -118.465969 , pinDetail : "3051 Antelo View Dr, Bel Air", pinTitle: "Pete Sampras"),
        
            Home(category:"Film & TV", name:"Meryl Streep", URL: "https://en.wikipedia.org/wiki/Meryl_Streep", pinLatitude: 34.099142, pinLongitude :  -118.383923 , pinDetail : "1514 Rising Glen Rd, Hollywood Hills", pinTitle: "Meryl Streep"),
        
            Home(category:"Music", name:"Harry Styles", URL: "https://en.wikipedia.org/wiki/Harry_Styles", pinLatitude: 34.116593, pinLongitude : -118.426097 , pinDetail : "9551 Oak Pass Rd, Beverly Hills", pinTitle: "Harry Styles"),
            
            Home(category:"Sport", name:"Ian Thorpe", URL: "https://en.wikipedia.org/wiki/Ian_Thorpe", pinLatitude: 34.103446, pinLongitude : -118.376989 , pinDetail : "8522 Oak Ct, Hollywood Hills", pinTitle: "Ian Thorpe"),
        
            Home(category:"Film & TV", name:"Tracey Ullman", URL: "https://en.wikipedia.org/wiki/Tracey_Ullman", pinLatitude: 34.079758, pinLongitude :  -118.486876 , pinDetail : "1200 N Tigertail Rd, Brentwood", pinTitle: "Tracey Ullman"),
        
            Home(category:"Film & TV", name:"Sofía Vergara", URL: "https://en.wikipedia.org/wiki/Sof%C3%ADa_Vergara", pinLatitude: 34.092560, pinLongitude :  -118.420344 , pinDetail : "1156 San Ysidro Dr, Beverly Hills", pinTitle: "Sofía Vergara"),
        
            Home(category:"Sport", name:"Chris Webber", URL: "https://en.wikipedia.org/wiki/Chris_Webber", pinLatitude: 34.044554, pinLongitude : -118.622946 , pinDetail : "20851 Big Rock Dr, Malibu", pinTitle: "Chris Webber"),
            
            Home(category:"Film & TV", name:"Mark Wahlberg", URL: "https://en.wikipedia.org/wiki/Mark_Wahlberg", pinLatitude: 34.116269, pinLongitude : -118.428752 , pinDetail : "9694 Oak Pass Rd, Beverly Hills", pinTitle: "Mark Wahlberg"),
        
            Home(category:"Sport", name:"Venus Williams", URL: "https://en.wikipedia.org/wiki/Venus_Williams", pinLatitude: 34.116546, pinLongitude : -118.356811 , pinDetail : "2521 Astral Dr, Hollywood Hills", pinTitle: "Venus Williams"),
        
            Home(category:"Film & TV", name:"Constance Zimmer", URL: "https://en.wikipedia.org/wiki/Constance_Zimmer", pinLatitude: 34.108610, pinLongitude : -118.314193 , pinDetail : "5715 Briarcliff Rd ,Hollywood Hills", pinTitle: "Constance Zimmer")]
        
        
        
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    deinit{
        if let superView = searchController.view.superview
        {
            superView.removeFromSuperview()
        }
    }
    
    // MARK: - Table View
    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if searchController.active && (searchController.searchBar.text != "" || !filteredHouse.isEmpty) {
            return filteredHouse.count
        }
        return House.count
    }
    
    
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("Cell", forIndexPath: indexPath)
        let house: Home
        
        if searchController.active && (searchController.searchBar.text != "" || !filteredHouse.isEmpty) {

            house = filteredHouse[indexPath.row]
            
        } else {
            house = House[indexPath.row]
        }
        cell.textLabel!.text = house.name
        cell.detailTextLabel!.text = house.category
        return cell
    }
    
    func filterContentForSearchText(searchText: String, scope: String = "All") {
        
        filteredHouse = House.filter({ house -> Bool in
            let categoryMatch = (scope == "All") || (house.category == scope)
            if searchText.isEmpty {
                return categoryMatch
            } else {
                return categoryMatch && house.name.lowercaseString.containsString(searchText.lowercaseString)
            }
        })
        tableView.reloadData()
    }
    
    // MARK: - Segues
    // MARK: - Segues
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "showDetailAll" {
            if let indexPath = tableView.indexPathForSelectedRow {
                let house: Home
                if searchController.active && (searchController.searchBar.text != "" || !filteredHouse.isEmpty){
                    house = filteredHouse[indexPath.row]
                } else {
                    house = House[indexPath.row]
                }
                
                let tabBar = segue.destinationViewController as? TBViewController
                let controller = tabBar?.viewControllers![0] as! DetailViewController
                let secondController = tabBar?.viewControllers![1] as! SecondDetailViewController

                
                controller.detailHouse = house
                secondController.detailHouse = house
                tabBar?.detailHouse = house
                secondController.navigationItem.leftItemsSupplementBackButton = true
                controller.navigationItem.leftItemsSupplementBackButton = true
                
                delay(0.5, closure: { () -> () in
                    self.dismissViewControllerAnimated(true, completion: nil)
                })
                
            }
        }
        
        }
    
    func bannerViewWillLoadAd(banner: ADBannerView!) {
        
        NSLog("Ad Loaded")
    }
    
    func bannerViewDidLoadAd(banner: ADBannerView!) {
        
            self.adBannerView?.hidden = false
        
    }
    
    func bannerView(banner: ADBannerView!, didFailToReceiveAdWithError error: NSError!) {
        self.adBannerView?.hidden = true
    }

    
}

func delay(delay:Double, closure:()->()) {
    dispatch_after(
        dispatch_time(
            DISPATCH_TIME_NOW,
            Int64(delay * Double(NSEC_PER_SEC))
        ),
        dispatch_get_main_queue(), closure)
}




                //self.dismissViewControllerAnimated(true, completion: nil)
 

extension AllSubTableViewController: UISearchBarDelegate {
    // MARK: - UISearchBar Delegate
    func searchBar(searchBar: UISearchBar, selectedScopeButtonIndexDidChange selectedScope: Int) {
        filterContentForSearchText(searchBar.text!, scope: searchBar.scopeButtonTitles![selectedScope])
    }
}

extension AllSubTableViewController: UISearchResultsUpdating {
    // MARK: - UISearchResultsUpdating Delegate
    func updateSearchResultsForSearchController(searchController: UISearchController) {
        let searchBar = searchController.searchBar
        let scope = searchBar.scopeButtonTitles![searchBar.selectedScopeButtonIndex]
        filterContentForSearchText(searchController.searchBar.text!, scope: scope)
    }
}