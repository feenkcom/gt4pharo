Extension { #name : #GtCoderNavigationTabsStencil }

{ #category : #'*GToolkit-Pharo-Changes' }
GtCoderNavigationTabsStencil >> gtRecentChangesFor: aView [
	<gtCoderNavigation>
	self navigationModel ifNil: [ ^ aView empty ].
	^ aView explicit
		priority: 10;
		title: 'Recent Changes';
		stencil: [ GtRecentChangeElement new navigationModel: self navigationModel ]
]
