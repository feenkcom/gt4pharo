Extension { #name : #String }

{ #category : #'*GToolkit-Pharo-Coder' }
String >> gtASTMatches [
	^ GtSearchAstFilter sourceExpression: self
]

{ #category : #'*GToolkit-Pharo-Coder' }
String >> gtASTMethodMatches [
	^ GtSearchAstFilter sourceMethod: self
]

{ #category : #'*GToolkit-Pharo-Coder' }
String >> gtClassMatches [
	^ GtSearchMethodsWithClassPatternFilter pattern: self
]

{ #category : #'*GToolkit-Pharo-Coder' }
String >> gtMethodProtocols [
	^ GtSearchMethodCategoryFilter forCategory: self
]

{ #category : #'*GToolkit-Pharo-Coder' }
String >> gtPackageMatches [
	^ GtSearchMethodsWithPackagePatternFilter pattern: self
]

{ #category : #'*GToolkit-Pharo-Coder' }
String >> gtReferences [
	^ GtSearchReferencesFilter literal: self
]

{ #category : #'*GToolkit-Pharo-Coder' }
String >> gtSubstringLiteralCaseSensitiveMatch [
	^ GtSearchLiteralStringFilter substring: self caseSensitive: true
]

{ #category : #'*GToolkit-Pharo-Coder' }
String >> gtSubstringLiteralMatch [
	^ GtSearchLiteralStringFilter substring: self
]

{ #category : #'*GToolkit-Pharo-Coder' }
String >> gtSubstringMatch [
	^ GtSubstringFilter substring: self
]
