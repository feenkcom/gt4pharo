Extension { #name : #Object }

{ #category : #'*GToolkit-Pharo-StrictSymbolChanges' }
Object class >> leFromJsonV4Dictionary: aDictionary [
	"Create a new instance of the receiver from the supplied dictionary.
	Subclasses can override this to provide custom mappings."
	| aLeModel |

	aLeModel := self new.
	self leJsonV4AttributeMapping do: [ :attributeMap |
		aDictionary 
			at: attributeMap value asString
			ifPresent: [ :aValue |
				aLeModel
					perform: attributeMap key asMutator
					with: aValue ]
			ifAbsent: [ "ignore it" ]
	].
	^ aLeModel
]
