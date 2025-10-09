Extension { #name : #GtSmaCCDiffSplitter }

{ #category : #'*GToolkit-Pharo-Coder' }
GtSmaCCDiffSplitter class >> forJSON [
	^ self new scannerClass: JSONScanner
]

{ #category : #'*GToolkit-Pharo-Coder' }
GtSmaCCDiffSplitter class >> forPharo [
	^ GtPharoDiffSplitter new scannerClass: GtPharoScanner
]

{ #category : #'*GToolkit-Pharo-Coder' }
GtSmaCCDiffSplitter class >> forPharoTokens [
	^ self new scannerClass: GtPharoScanner
]
