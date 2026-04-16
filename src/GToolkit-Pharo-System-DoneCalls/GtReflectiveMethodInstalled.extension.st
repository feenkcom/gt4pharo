Extension { #name : #GtReflectiveMethodInstalled }

{ #category : #'*GToolkit-Pharo-System-DoneCalls' }
GtReflectiveMethodInstalled >> gtDoneAnnouncementIn: anAnnouncer [
	#GtReflectiveMethodInstalledDone
		asClassIfPresent: [ :anAnnouncementClass | 
			anAnnouncer announce: (anAnnouncementClass new
				oldMethod: self oldMethod;
				newMethod: self newMethod;
				yourself) ]
]
