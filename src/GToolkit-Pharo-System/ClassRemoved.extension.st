Extension { #name : #ClassRemoved }

{ #category : #'*GToolkit-Pharo-System' }
ClassRemoved >> gtDoneAnnouncementIn: anAnnouncer [
	#GtClassRemovedDone
		asClassIfPresent: [ :anAnnouncementClass |
			anAnnouncer announce: (anAnnouncementClass class: self classAffected) ]
]
