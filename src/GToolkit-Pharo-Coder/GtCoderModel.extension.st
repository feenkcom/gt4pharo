Extension { #name : #GtCoderModel }

{ #category : #'*GToolkit-Pharo-Coder' }
GtCoderModel class >> gtAstCoderAddOnsFor: aView context: aPhlowContext [
	<gtClassView>
	^ aView explicit
		title: 'Coder AddOns';
		priority: 60;
		stencil: [ 
			#gtAstCoderAddOns: gtPragmas
				& (GtSearchMethodsInClassFilter new 
					forClass: self;
					includeSuperclass: true) ]
]
