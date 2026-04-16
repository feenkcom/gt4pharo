Extension { #name : #ClassRenamed }

{ #category : #'*GToolkit-Pharo-System' }
ClassRenamed >> gtDoneAnnouncementIn: anAnnouncer [
	#GtClassRenamedDone
		asClassIfPresent: [ :anAnnouncementClass | 
			anAnnouncer
				announce: (anAnnouncementClass
						class: self classAffected
						oldName: self oldName
						newName: self newName) ]
]
