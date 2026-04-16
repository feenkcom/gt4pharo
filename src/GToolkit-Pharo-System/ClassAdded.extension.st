Extension { #name : #ClassAdded }

{ #category : #'*GToolkit-Pharo-System' }
ClassAdded >> gtDoneAnnouncementIn: anAnnouncer [
	#GtClassAddedDone
		asClassIfPresent: [ :anAnnouncementClass |
			anAnnouncer announce: (anAnnouncementClass class: self classAffected) ]
]
