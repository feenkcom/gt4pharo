Extension { #name : #ClassDescription }

{ #category : #'*GToolkit-Pharo-Extensions' }
ClassDescription >> packageTagName [
	"Package tags are sub categories of packages to have a better organization of the packages. I return the name of my package tag.."

	^ self packageTag name
]
