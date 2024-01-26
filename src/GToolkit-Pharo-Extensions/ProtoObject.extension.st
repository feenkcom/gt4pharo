Extension { #name : #ProtoObject }

{ #category : #'*GToolkit-Pharo-Extensions' }
ProtoObject >> gtMetaFor: aView [
	<gtView>
	^ aView explicit
		title: 'Meta';
		priority: 200;
		stencil: [ (GtCoderElement forObject: self) disablePlayPage beNormalLevel ]
]
