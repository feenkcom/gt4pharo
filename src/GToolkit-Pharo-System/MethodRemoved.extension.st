Extension { #name : #MethodRemoved }

{ #category : #'*GToolkit-Pharo-System' }
MethodRemoved >> gtDoneAnnouncementIn: anAnnouncer [
	#GtMethodRemovedDone
		asClassIfPresent: [ :anAnnouncementClass | 
			anAnnouncer announce: (anAnnouncementClass methodRemoved: self method origin: self methodOrigin) ]
]
