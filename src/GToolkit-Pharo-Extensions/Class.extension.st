Extension { #name : #Class }

{ #category : #'*GToolkit-Pharo-Extensions' }
Class >> gtMetaFor: aView [
	<gtView>
	^ aView explicit
		title: 'Meta';
		priority: 200;
		stencil: [ (GtCoderElement forClass: self) disablePlayPage ]
]
