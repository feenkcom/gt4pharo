Extension { #name : #ClassParentRenamed }

{ #category : #'*GToolkit-Pharo-System' }
ClassParentRenamed >> gtDoneAnnouncementIn: anAnnouncer [
	#GtClassParentRenamedDone
		asClassIfPresent: [ :anAnnouncementClass |
			anAnnouncer announce: (anAnnouncementClass
				classParentOf: self classAffected
				renamedFrom: self parentOldName
				to: self parentNewName) ]
]
