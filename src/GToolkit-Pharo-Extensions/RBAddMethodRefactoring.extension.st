Extension { #name : #RBAddMethodRefactoring }

{ #category : #'*GToolkit-Pharo-Extensions' }
RBAddMethodRefactoring >> gtDescription [
	^ 'Add method'
]

{ #category : #'*GToolkit-Pharo-Extensions' }
RBAddMethodRefactoring >> gtSource [
	^ source
]

{ #category : #'*GToolkit-Pharo-Extensions' }
RBAddMethodRefactoring >> gtViewMethodCodeFor: aView [
	<gtView>
	
	^ aView textEditor 
		title: 'Method Code';
		text: [ source asRopedText ];
		styler: [BrRBTextStyler new ];
		aptitude: BrGlamorousCodeEditorAptitude
]
