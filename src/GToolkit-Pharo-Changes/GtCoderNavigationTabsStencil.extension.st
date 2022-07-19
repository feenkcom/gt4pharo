Extension { #name : #GtCoderNavigationTabsStencil }

{ #category : #'*GToolkit-Pharo-Changes' }
GtCoderNavigationTabsStencil >> gtRecentChangesFor: aView [
	<gtCoderNavigation>
	self navigationModel ifNil: [ ^ aView empty ].
	^ aView forward
		priority: 10;
		title: 'Recent Changes';
		updateWhen: MethodAnnouncement in: [ SystemAnnouncer uniqueInstance ];
		object: [ GtRecentChanges new ];
		view: #gtTreeFor:;
		send: [ :item | item navigateToUsingModel: self navigationModel ]
]
