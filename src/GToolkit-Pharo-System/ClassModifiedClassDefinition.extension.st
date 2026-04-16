Extension { #name : #ClassModifiedClassDefinition }

{ #category : #'*GToolkit-Pharo-System' }
ClassModifiedClassDefinition >> gtDoneAnnouncementIn: anAnnouncer [
	#GtClassModifiedClassDefinitionDone
		asClassIfPresent: [ :anAnnouncementClass |
			anAnnouncer announce: (anAnnouncementClass
				classDefinitionChangedFrom: self oldClassDefinition
				to: self newClassDefinition) ]
]
