Extension { #name : #ClassAdded }

{ #category : #'*GToolkit-Pharo-System-DoneCalls' }
ClassAdded >> gtDoneAnnouncementIn: anAnnouncer [
	#GtClassAddedDone
		asClassIfPresent: [ :anAnnouncementClass |
			anAnnouncer announce: (anAnnouncementClass class: self classAffected) ]
]
