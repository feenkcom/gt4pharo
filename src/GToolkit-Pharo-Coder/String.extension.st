Extension { #name : #String }

{ #category : #'*GToolkit-Pharo-Coder' }
String >> gtASTMatches [
	^ GtSearchRBASTFilter sourceExpression: self
]

{ #category : #'*GToolkit-Pharo-Coder' }
String >> gtASTMethodMatches [
	^ GtSearchRBASTFilter sourceMethod: self
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
String >> gtPragmas [
	^ GtSearchPragmasFilter forPragma: self
]

{ #category : #'*GToolkit-Pharo-Coder' }
String >> gtPragmasWithArguments: anArray [
	^ GtSearchPragmasWithArgumentsFilter forPragma: self withArguments: anArray
]

{ #category : #'*GToolkit-Pharo-Coder' }
String >> gtRBPatternMatches [
	^ GtSearchRBPatternFilter pattern: self
]

{ #category : #'*GToolkit-Pharo-Coder' }
String >> gtReferences [
	^ GtSearchReferencesFilter literal: self
]

{ #category : #'*GToolkit-Pharo-Coder' }
String >> gtRepositoryMatches [
	^ GtSearchMethodsWithRepositoryPatternFilter pattern: self
]

{ #category : #'*GToolkit-Pharo-Coder' }
String >> gtStringLiteralCaseSensitiveMatch [
	^ GtSearchLiteralExactStringFilter string: self caseSensitive: true
]

{ #category : #'*GToolkit-Pharo-Coder' }
String >> gtStringLiteralMatch [
	^ GtSearchLiteralExactStringFilter string: self caseSensitive: false
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
