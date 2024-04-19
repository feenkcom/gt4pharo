Extension { #name : #OCBytecodeToASTCache }

{ #category : #'*GToolkit-Pharo-Extensions' }
OCBytecodeToASTCache >> gtDisplayOn: aStream [
	super gtDisplayOn: aStream.
	
	aStream parenthesize: [
		aStream 
			<< 'firstBC: ';
			print: self firstBcOffset;
			<< '; lastBC: ';
			print: self lastBcOffset]
]

{ #category : #'*GToolkit-Pharo-Extensions' }
OCBytecodeToASTCache >> gtViewBcToAstMapFor: aView [ 
	<gtView>
	
	^ aView forward 
		title: 'BC to AST Map';
		object: [ self bcToASTMap ];
		view: #gtItemsFor:
]
