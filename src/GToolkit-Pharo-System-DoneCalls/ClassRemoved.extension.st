Extension { #name : #ClassRemoved }

{ #category : #'*GToolkit-Pharo-System-DoneCalls' }
ClassRemoved >> gtDoneAnnouncementIn: anAnnouncer [
	#GtClassRemovedDone
		asClassIfPresent: [ :anAnnouncementClass |
			anAnnouncer announce: (anAnnouncementClass class: self classAffected) ]
]
