Extension { #name : #MethodAdded }

{ #category : #'*GToolkit-Pharo-System' }
MethodAdded >> gtDoneAnnouncementIn: anAnnouncer [
	#GtMethodAddedDone
		asClassIfPresent: [ :anAnnouncementClass | 
			anAnnouncer announce: (anAnnouncementClass method: self methodAdded) ]
]
