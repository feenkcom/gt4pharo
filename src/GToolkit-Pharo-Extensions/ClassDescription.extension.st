Extension { #name : #ClassDescription }

{ #category : #'*GToolkit-Pharo-Extensions' }
ClassDescription >> gtProtocols [
	"Utility method to handle differences in behaviour 
	between ClassDescription>>#protocols in Pharo 11 and Pharo 12.
	
	In Pharo 11 ClassDescription>>#protocols returns a list of strings, and in Pharo 12 it returns an array of protocol objects. This keeps the behaviour of returning an empty an list of protocol objects.
	
	Should be removed and just protocols should be used once we no longer need to support Pharo 11"
	
	^ self
		forPharo12AndNewer: [ self protocols]
		forPharo11: [ self organization protocols ].
]

{ #category : #'*GToolkit-Pharo-Extensions' }
ClassDescription >> packageTagName [
	"Package tags are sub categories of packages to have a better organization of the packages. I return the name of my package tag.."

	^ self packageTag name
]
