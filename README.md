#  Troubleshooting

To fix the syntax issue relating to swinject storyboard third party library
1. add the code below inside of SwinjectStoryboardOption class:
    func hash(into: inout Hasher) {
        
    }
