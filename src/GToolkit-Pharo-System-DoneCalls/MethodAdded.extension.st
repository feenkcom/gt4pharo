Extension { #name : #MethodAdded }

{ #category : #'*GToolkit-Pharo-System-DoneCalls' }
MethodAdded >> gtDoneAnnouncementIn: anAnnouncer [
	#GtMethodAddedDone
		asClassIfPresent: [ :anAnnouncementClass | 
			anAnnouncer announce: (anAnnouncementClass method: self methodAdded) ]
]
