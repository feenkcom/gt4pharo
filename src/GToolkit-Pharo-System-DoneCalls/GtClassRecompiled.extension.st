Extension { #name : #GtClassRecompiled }

{ #category : #'*GToolkit-Pharo-System-DoneCalls' }
GtClassRecompiled >> gtDoneAnnouncementIn: anAnnouncer [
	#GtClassRecompiledDone
		asClassIfPresent: [ :anAnnouncementClass |
			anAnnouncer announce: (anAnnouncementClass new classAffected: self classAffected; yourself) ]
]
