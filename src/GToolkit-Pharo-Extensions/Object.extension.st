Extension { #name : 'Object' }

{ #category : '*GToolkit-Pharo-Extensions' }
Object >> gtMetaFor: aView [
	<gtView>
	^ aView explicit
		title: 'Meta';
		priority: 200;
		stencil: [ (GtPharoBehaviorCoder forObject: self) asElement ]
]
