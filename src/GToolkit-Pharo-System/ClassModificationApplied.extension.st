Extension { #name : #ClassModificationApplied }

{ #category : #'*GToolkit-Pharo-System' }
ClassModificationApplied >> gtDoneAnnouncementIn: anAnnouncer [
	#GtClassModificationAppliedDone
		asClassIfPresent: [ :anAnnouncementClass |
			anAnnouncer announce: (anAnnouncementClass toClass: self classAffected) ]
]
