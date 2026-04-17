Extension { #name : #ClassModificationApplied }

{ #category : #'*GToolkit-Pharo-System-DoneCalls' }
ClassModificationApplied >> gtDoneAnnouncementIn: anAnnouncer [
	#GtClassModificationAppliedDone
		asClassIfPresent: [ :anAnnouncementClass |
			anAnnouncer announce: (anAnnouncementClass toClass: self classAffected) ]
]
