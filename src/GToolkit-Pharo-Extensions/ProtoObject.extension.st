Extension { #name : #ProtoObject }

{ #category : #'*GToolkit-Pharo-Extensions' }
ProtoObject >> gtMetaFor: aView [
	<gtView>
	^ aView explicit
		title: 'Meta';
		priority: 200;
		stencil: [ BrVerticalPane new
				matchParent;
				background: BrGlamorousColors backdropColor;  
				addChild: ((GtCoderElement forObject: self) disablePlayPage "beNormalLevel"
						margin: (BlInsets all: 10);
						background: Color white;
						addAptitude: BrShadowAptitude) ]
]
