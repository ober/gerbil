;;; -*- Gerbil -*-
;;; © vyzo
;;; gerbil core prelude: runtime builtins
;;;
prelude: :<root>
package: gerbil/core

(export #t (import: Runtime))

;;;
;;; r5rs scheme
;;;
(module R5RSRuntime
  (export #t)
  (extern namespace: #f
    ;; R4RS
    *
    +
    -
    /
    <
    <=
    =
    >
    >=
    abs
    acos
    angle
    append
    apply
    asin
    assoc
    assq
    assv
    atan
    boolean?
    caaaar
    caaadr
    caaar
    caadar
    caaddr
    caadr
    caar
    cadaar
    cadadr
    cadar
    caddar
    cadddr
    caddr
    cadr
    call-with-current-continuation
    call-with-input-file
    call-with-output-file
    car
    cdaaar
    cdaadr
    cdaar
    cdadar
    cdaddr
    cdadr
    cdar
    cddaar
    cddadr
    cddar
    cdddar
    cddddr
    cdddr
    cddr
    cdr
    ceiling
    char->integer
    char-alphabetic?
    char-ci<=?
    char-ci<?
    char-ci=?
    char-ci>=?
    char-ci>?
    char-downcase
    char-lower-case?
    char-numeric?
    char-ready?
    char-upcase
    char-upper-case?
    char-whitespace?
    char<=?
    char<?
    char=?
    char>=?
    char>?
    char?
    close-input-port
    close-output-port
    complex?
    cons
    cos
    current-input-port
    current-output-port
    denominator
    display
    eof-object?
    eq?
    equal?
    eqv?
    even?
    exact->inexact
    exact?
    exp
    expt
    floor
    for-each
    force
    gcd
    imag-part
    inexact->exact
    inexact?
    input-port?
    integer->char
    integer?
    lcm
    length
    list
    list->string
    list->vector
    list-ref
    list-tail
    list?
    load
    log
    magnitude
    make-polar
    make-rectangular
    make-string
    make-vector
    map
    max
    member
    memq
    memv
    min
    modulo
    negative?
    newline
    not
    null?
    number->string
    number?
    numerator
    odd?
    open-input-file
    open-output-file
    output-port?
    pair?
    peek-char
    positive?
    procedure?
    quotient
    rational?
    rationalize
    read
    read-char
    real-part
    real?
    remainder
    reverse
    round
    set-car!
    set-cdr!
    sin
    sqrt
    string
    string->list
    string->number
    string->symbol
    string-append
    string-ci<=?
    string-ci<?
    string-ci=?
    string-ci>=?
    string-ci>?
    string-copy
    string-fill!
    string-length
    string-ref
    string-set!
    string<=?
    string<?
    string=?
    string>=?
    string>?
    string?
    substring
    symbol->string
    symbol?
    tan
    transcript-off
    transcript-on
    truncate
    vector
    vector->list
    vector-fill!
    vector-length
    vector-ref
    vector-set!
    vector?
    with-input-from-file
    with-output-to-file
    write
    write-char
    zero?

    ;; procedures that R5RS adds to R4RS
    call-with-values
    dynamic-wind
    eval
    interaction-environment
    null-environment
    scheme-report-environment
    values
    ))

;;;
;;; r7rs scheme
;;;
(module R7RSRuntime
  (export #t)
  (extern namespace: #f
    ;; procedures that R7RS adds to R5RS
    balanced-quotient
    balanced-remainder
    balanced/
    binary-port?
    boolean=?
    bytevector
    bytevector-append
    bytevector-copy
    bytevector-copy!
    bytevector-length
    bytevector-u8-ref
    bytevector-u8-set!
    bytevector?
    call-with-port
    ceiling-quotient
    ceiling-remainder
    ceiling/
    char-foldcase
    close-port
    command-line
    current-error-port
    current-jiffy
    current-second
    delete-file
    digit-value
    emergency-exit
    eof-object
    error-object-irritants
    error-object-message
    error-object?
    euclidean-quotient
    euclidean-remainder
    euclidean/
    exact
    exact-integer-sqrt
    exact-integer?
    exit
    features
    file-error?
    file-exists?
    finite?
    floor-quotient
    floor-remainder
    floor/
    flush-output-port
    get-environment-variable
    get-environment-variables
    get-output-bytevector
    get-output-string
    inexact
    infinite?
    input-port-open?
    jiffies-per-second
    list-copy
    list-set!
    make-bytevector
    make-list
    make-parameter
    make-promise
    nan?
    open-binary-input-file
    open-binary-output-file
    open-input-bytevector
    open-input-string
    open-output-bytevector
    open-output-string
    output-port-open?
    peek-u8
    port?
    promise?
    read-bytevector
    read-bytevector!
    read-error?
    read-line
    read-string
    read-u8
    round-quotient
    round-remainder
    round/
    square
    string->utf8
    string->vector
    string-copy!
    string-downcase
    string-foldcase
    string-for-each
    string-map
    string-upcase
    symbol=?
    textual-port?
    truncate-quotient
    truncate-remainder
    truncate/
    u8-ready?
    utf8->string
    vector->string
    vector-append
    vector-copy
    vector-copy!
    vector-for-each
    vector-map
    write-bytevector
    write-shared
    write-simple
    write-string
    write-u8
    ))

;;;
;;; gambit scheme
;;;
(module GambitRuntime
  (export #t)
  (extern namespace: #f
    ;; source: gambit.sld
    ;; procedures and globals provided by Gambit

    ;; globals
    default-random-source

    ;; macros
    time

    ;; procedures
    ->char-set
    abandoned-mutex-exception?
    abort
    acosh
    address-info-family
    address-info-protocol
    address-info-socket-info
    address-info-socket-type
    address-info?
    address-infos
    all-bits-set?
    any
    any-bit-set?
    any-bits-set?
    append!
    append-reverse
    append-reverse!
    apropos
    arithmetic-shift
    asinh
    atanh
    bit-count
    bit-field
    bit-field-any?
    bit-field-clear
    bit-field-every?
    bit-field-replace
    bit-field-replace-same
    bit-field-reverse
    bit-field-rotate
    bit-field-set
    bit-set?
    bit-swap
    bits
    bits->list
    bits->vector
    bitwise-and
    bitwise-andc1
    bitwise-andc2
    bitwise-eqv
    bitwise-fold
    bitwise-for-each
    bitwise-if
    bitwise-ior
    bitwise-merge
    bitwise-nand
    bitwise-nor
    bitwise-not
    bitwise-orc1
    bitwise-orc2
    bitwise-unfold
    bitwise-xor
    box
    box?
    break
    call-with-input-process
    call-with-input-string
    call-with-input-u8vector
    call-with-input-vector
    call-with-output-process
    call-with-output-string
    call-with-output-u8vector
    call-with-output-vector
    call/cc
    car+cdr
    cfun-conversion-exception-arguments
    cfun-conversion-exception-code
    cfun-conversion-exception-message
    cfun-conversion-exception-procedure
    cfun-conversion-exception?
    char-set
    char-set->list
    char-set->string
    char-set-adjoin
    char-set-adjoin!
    char-set-any
    char-set-complement
    char-set-complement!
    char-set-contains?
    char-set-copy
    char-set-count
    char-set-cursor
    char-set-cursor-next
    char-set-delete
    char-set-delete!
    char-set-diff+intersection
    char-set-diff+intersection!
    char-set-difference
    char-set-difference!
    char-set-every
    char-set-filter
    char-set-filter!
    char-set-fold
    char-set-for-each
    char-set-hash
    char-set-intersection
    char-set-intersection!
    char-set-map
    char-set-ref
    char-set-size
    char-set-unfold
    char-set-unfold!
    char-set-union
    char-set-union!
    char-set-xor
    char-set-xor!
    char-set<=
    char-set=
    char-set?
    circular-list
    circular-list?
    clear-bit-field
    command-args
    command-name
    compilation-target
    compile-file
    compile-file-to-target
    concatenate
    concatenate!
    condition-variable-broadcast!
    condition-variable-name
    condition-variable-signal!
    condition-variable-specific
    condition-variable-specific-set!
    condition-variable?
    configure-command-string
    conjugate
    cons*
    console-port
    continuation-capture
    continuation-graft
    continuation-return
    continuation?
    copy-bit
    copy-bit-field
    copy-file
    cosh
    cpu-time
    create-directory
    create-fifo
    create-link
    create-symbolic-link
    create-temporary-directory
    current-directory
    current-exception-handler
    current-processor
    current-readtable
    current-thread
    current-time
    current-user-interrupt-handler
    ;; datum->syntax
    datum-parsing-exception-kind
    datum-parsing-exception-parameters
    datum-parsing-exception-readenv
    datum-parsing-exception?
    dead-end
    deadlock-exception?
    default-user-interrupt-handler
    defer-user-interrupts
    delete
    delete!
    delete-directory
    delete-file-or-directory
    directory-files
    display-continuation-backtrace
    display-continuation-dynamic-environment
    display-continuation-environment
    display-exception
    display-exception-in-context
    display-procedure-environment
    divide-by-zero-exception-arguments
    divide-by-zero-exception-procedure
    divide-by-zero-exception?
    dotted-list?
    drop
    drop-right
    drop-right!
    eighth
    end-of-char-set?
    eq?-hash
    equal?-hash
    eqv?-hash
    err-code->string
    error
    error-exception-message
    error-exception-parameters
    error-exception?
    every
    every-bit-set?
    executable-path
    expression-parsing-exception-kind
    expression-parsing-exception-parameters
    expression-parsing-exception-source
    expression-parsing-exception?
    extract-bit-field
    f32vector
    f32vector->list
    f32vector-append
    f32vector-concatenate
    f32vector-copy
    f32vector-copy!
    f32vector-fill!
    f32vector-length
    f32vector-ref
    f32vector-set
    f32vector-set!
    f32vector-shrink!
    f32vector-swap!
    f32vector?
    f64vector
    f64vector->list
    f64vector-append
    f64vector-concatenate
    f64vector-copy
    f64vector-copy!
    f64vector-fill!
    f64vector-length
    f64vector-ref
    f64vector-set
    f64vector-set!
    f64vector-shrink!
    f64vector-swap!
    f64vector?
    fifth
    file-attributes
    file-creation-time
    file-device
    file-exists-exception-arguments
    file-exists-exception-procedure
    file-exists-exception?
    file-group
    file-info
    file-info-attributes
    file-info-creation-time
    file-info-device
    file-info-group
    file-info-inode
    file-info-last-access-time
    file-info-last-change-time
    file-info-last-modification-time
    file-info-mode
    file-info-number-of-links
    file-info-owner
    file-info-size
    file-info-type
    file-info?
    file-inode
    file-last-access-and-modification-times-set!
    file-last-access-time
    file-last-change-time
    file-last-modification-time
    file-mode
    file-number-of-links
    file-owner
    file-size
    file-type
    filter
    filter!
    first
    first-set-bit
    fixnum->flonum
    fixnum-overflow-exception-arguments
    fixnum-overflow-exception-procedure
    fixnum-overflow-exception?
    fixnum?
    fl*
    fl+
    fl+*
    fl-
    fl/
    fl<
    fl<=
    fl=
    fl>
    fl>=
    flabs
    flacos
    flacosh
    flasin
    flasinh
    flatan
    flatanh
    flceiling
    flcos
    flcosh
    fldenominator
    fleven?
    flexp
    flexpm1
    flexpt
    flfinite?
    flfloor
    flhypot
    flilogb
    flinfinite?
    flinteger?
    fllog
    fllog1p
    flmax
    flmin
    flnan?
    flnegative?
    flnumerator
    flodd?
    flonum?
    flpositive?
    flround
    flscalbn
    flsin
    flsinh
    flsqrt
    flsquare
    fltan
    fltanh
    fltruncate
    flzero?
    fold
    fold-right
    force-output
    foreign-address
    foreign-release!
    foreign-released?
    foreign-tags
    foreign?
    fourth
    fx*
    fx+
    fx-
    fx<
    fx<=
    fx=
    fx>
    fx>=
    fxabs
    fxand
    fxandc1
    fxandc2
    fxarithmetic-shift
    fxarithmetic-shift-left
    fxarithmetic-shift-right
    fxbit-count
    fxbit-set?
    fxeqv
    fxeven?
    fxfirst-set-bit
    fxif
    fxior
    fxlength
    fxmax
    fxmin
    fxmodulo
    fxnand
    fxnegative?
    fxnor
    fxnot
    fxodd?
    fxorc1
    fxorc2
    fxpositive?
    fxquotient
    fxremainder
    fxsquare
    fxwrap*
    fxwrap+
    fxwrap-
    fxwrapabs
    fxwraparithmetic-shift
    fxwraparithmetic-shift-left
    fxwraplogical-shift-right
    fxwrapquotient
    fxwrapsquare
    fxxor
    fxzero?
    gc-report-set!
    generate-proper-tail-calls
    gensym
    get-output-u8vector
    get-output-vector
    getenv
    group-info
    group-info-gid
    group-info-members
    group-info-name
    group-info?
    heap-overflow-exception?
    help
    help-browser
    host-info
    host-info-addresses
    host-info-aliases
    host-info-name
    host-info?
    host-name
    identity
    inactive-thread-exception-arguments
    inactive-thread-exception-procedure
    inactive-thread-exception?
    initial-current-directory
    initialized-thread-exception-arguments
    initialized-thread-exception-procedure
    initialized-thread-exception?
    input-port-byte-position
    input-port-bytes-buffered
    input-port-char-position
    input-port-characters-buffered
    input-port-column
    input-port-line
    input-port-readtable
    input-port-readtable-set!
    input-port-timeout-set!
    integer-length
    integer-nth-root
    integer-sqrt
    invalid-hash-number-exception-arguments
    invalid-hash-number-exception-procedure
    invalid-hash-number-exception?
    invalid-utf8-encoding-exception-arguments
    invalid-utf8-encoding-exception-procedure
    invalid-utf8-encoding-exception?
    iota
    join-timeout-exception-arguments
    join-timeout-exception-procedure
    join-timeout-exception?
    keyword->string
    keyword-expected-exception-arguments
    keyword-expected-exception-procedure
    keyword-expected-exception?
    keyword-hash
    keyword?
    last
    last-pair
    length+
    length-mismatch-exception-arg-id
    length-mismatch-exception-arguments
    length-mismatch-exception-procedure
    length-mismatch-exception?
    link-flat
    link-incremental
    list->bits
    list->char-set
    list->char-set!
    list->f32vector
    list->f64vector
    list->s16vector
    list->s32vector
    list->s64vector
    list->s8vector
    list->table
    list->u16vector
    list->u32vector
    list->u64vector
    list->u8vector
    list-set
    list-sort
    list-sort!
    list-tabulate
    list=
    mailbox-receive-timeout-exception-arguments
    mailbox-receive-timeout-exception-procedure
    mailbox-receive-timeout-exception?
    main
    make-bitwise-generator
    make-condition-variable
    make-f32vector
    make-f64vector
    make-mutex
    make-random-source
    make-root-thread
    make-s16vector
    make-s32vector
    make-s64vector
    make-s8vector
    make-table
    make-thread
    make-thread-group
    make-tls-context
    make-u16vector
    make-u32vector
    make-u64vector
    make-u8vector
    make-will
    module-not-found-exception-arguments
    module-not-found-exception-procedure
    module-not-found-exception?
    module-search-order-add!
    module-search-order-reset!
    module-whitelist-add!
    module-whitelist-reset!
    multiple-c-return-exception?
    mutex-lock!
    mutex-name
    mutex-specific
    mutex-specific-set!
    mutex-state
    mutex-unlock!
    mutex?
    network-info
    network-info-aliases
    network-info-name
    network-info-number
    network-info?
    ninth
    no-such-file-or-directory-exception-arguments
    no-such-file-or-directory-exception-procedure
    no-such-file-or-directory-exception?
    noncontinuable-exception-reason
    noncontinuable-exception?
    nonempty-input-port-character-buffer-exception-arguments
    nonempty-input-port-character-buffer-exception-procedure
    nonempty-input-port-character-buffer-exception?
    nonprocedure-operator-exception-arguments
    nonprocedure-operator-exception-code
    nonprocedure-operator-exception-operator
    nonprocedure-operator-exception-rte
    nonprocedure-operator-exception?
    not-in-compilation-context-exception-arguments
    not-in-compilation-context-exception-procedure
    not-in-compilation-context-exception?
    not-pair?
    null-list?
    number-of-arguments-limit-exception-arguments
    number-of-arguments-limit-exception-procedure
    number-of-arguments-limit-exception?
    object->serial-number
    object->string
    object->u8vector
    open-directory
    open-dummy
    open-event-queue
    open-file
    open-input-process
    open-input-u8vector
    open-input-vector
    open-output-bytevector
    open-output-process
    open-output-u8vector
    open-output-vector
    open-process
    open-string
    open-string-pipe
    open-tcp-client
    open-tcp-server
    open-u8vector
    open-u8vector-pipe
    open-udp
    open-vector
    open-vector-pipe
    os-exception-arguments
    os-exception-code
    os-exception-message
    os-exception-procedure
    os-exception?
    output-port-byte-position
    output-port-char-position
    output-port-column
    output-port-line
    output-port-readtable
    output-port-readtable-set!
    output-port-timeout-set!
    output-port-width
    partition
    partition!
    path-directory
    path-expand
    path-extension
    path-normalize
    path-strip-directory
    path-strip-extension
    path-strip-trailing-directory-separator
    path-strip-volume
    path-volume
    permission-denied-exception-arguments
    permission-denied-exception-procedure
    permission-denied-exception?
    poll-point
    port-io-exception-handler-set!
    port-settings-set!
    pp
    pretty-print
    primordial-exception-handler
    print
    println
    process-pid
    process-status
    process-times
    processor-id
    processor?
    proper-list?
    protocol-info
    protocol-info-aliases
    protocol-info-name
    protocol-info-number
    protocol-info?
    r7rs-raise
    r7rs-raise-continuable
    r7rs-with-exception-handler
    raise
    random-f64vector
    random-integer
    random-real
    random-source-make-f64vectors
    random-source-make-integers
    random-source-make-reals
    random-source-make-u8vectors
    random-source-pseudo-randomize!
    random-source-randomize!
    random-source-state-ref
    random-source-state-set!
    random-source?
    random-u8vector
    range-exception-arg-id
    range-exception-arguments
    range-exception-procedure
    range-exception?
    read-all
    read-file-string
    read-file-string-list
    read-file-u8vector
    read-substring
    read-subu8vector
    readtable-case-conversion?
    readtable-case-conversion?-set
    readtable-comment-handler
    readtable-comment-handler-set
    readtable-eval-allowed?
    readtable-eval-allowed?-set
    readtable-keywords-allowed?
    readtable-keywords-allowed?-set
    readtable-max-unescaped-char
    readtable-max-unescaped-char-set
    readtable-max-write-length
    readtable-max-write-length-set
    readtable-max-write-level
    readtable-max-write-level-set
    readtable-sharing-allowed?
    readtable-sharing-allowed?-set
    readtable-start-syntax
    readtable-start-syntax-set
    readtable-write-cdr-read-macros?
    readtable-write-cdr-read-macros?-set
    readtable-write-extended-read-macros?
    readtable-write-extended-read-macros?-set
    readtable?
    real-time
    remove
    remove!
    remq
    rename-file
    repl-backtrace-detail-level
    repl-highlight-source-level
    repl-error-port
    repl-input-port
    repl-output-port
    repl-result-history-max-length-set!
    repl-result-history-ref
    replace-bit-field
    reverse!
    rpc-remote-error-exception-arguments
    rpc-remote-error-exception-message
    rpc-remote-error-exception-procedure
    rpc-remote-error-exception?
    s16vector
    s16vector->list
    s16vector-append
    s16vector-concatenate
    s16vector-copy
    s16vector-copy!
    s16vector-fill!
    s16vector-length
    s16vector-ref
    s16vector-set
    s16vector-set!
    s16vector-shrink!
    s16vector-swap!
    s16vector?
    s32vector
    s32vector->list
    s32vector-append
    s32vector-concatenate
    s32vector-copy
    s32vector-copy!
    s32vector-fill!
    s32vector-length
    s32vector-ref
    s32vector-set
    s32vector-set!
    s32vector-shrink!
    s32vector-swap!
    s32vector?
    s64vector
    s64vector->list
    s64vector-append
    s64vector-concatenate
    s64vector-copy
    s64vector-copy!
    s64vector-fill!
    s64vector-length
    s64vector-ref
    s64vector-set
    s64vector-set!
    s64vector-shrink!
    s64vector-swap!
    s64vector?
    s8vector
    s8vector->list
    s8vector-append
    s8vector-concatenate
    s8vector-copy
    s8vector-copy!
    s8vector-fill!
    s8vector-length
    s8vector-ref
    s8vector-set
    s8vector-set!
    s8vector-shrink!
    s8vector-swap!
    s8vector?
    scheduler-exception-reason
    scheduler-exception?
    script-directory
    script-file
    second
    seconds->time
    serial-number->object
    service-info
    service-info-aliases
    service-info-name
    service-info-port-number
    service-info-protocol
    service-info?
    set-box!
    setenv
    seventh
    sfun-conversion-exception-arguments
    sfun-conversion-exception-code
    sfun-conversion-exception-message
    sfun-conversion-exception-procedure
    sfun-conversion-exception?
    shell-command
    sinh
    sixth
    socket-info-address
    socket-info-family
    socket-info-port-number
    socket-info?
    split-at
    split-at!
    stack-overflow-exception?
    started-thread-exception-arguments
    started-thread-exception-procedure
    started-thread-exception?
    step
    step-level-set!
    string->char-set
    string->char-set!
    string->keyword
    string->uninterned-keyword
    string->uninterned-symbol
    string-ci=?-hash
    string-concatenate
    string-contains
    string-contains-ci
    string-prefix-ci?
    string-prefix-length
    string-prefix-length-ci
    string-prefix?
    string-set
    string-shrink!
    string-suffix-ci?
    string-suffix-length
    string-suffix-length-ci
    string-suffix?
    string-swap!
    string=?-hash
    subf32vector
    subf32vector-fill!
    subf32vector-move!
    subf64vector
    subf64vector-fill!
    subf64vector-move!
    subs16vector
    subs16vector-fill!
    subs16vector-move!
    subs32vector
    subs32vector-fill!
    subs32vector-move!
    subs64vector
    subs64vector-fill!
    subs64vector-move!
    subs8vector
    subs8vector-fill!
    subs8vector-move!
    substring-fill!
    substring-move!
    subu16vector
    subu16vector-fill!
    subu16vector-move!
    subu32vector
    subu32vector-fill!
    subu32vector-move!
    subu64vector
    subu64vector-fill!
    subu64vector-move!
    subu8vector
    subu8vector-fill!
    subu8vector-move!
    subvector
    subvector-fill!
    subvector-move!
    symbol-hash
    ;; syntax->datum
    ;; syntax->list
    ;; syntax->vector
    system-stamp
    system-type
    system-type-string
    system-version
    system-version-string
    table->list
    table-copy
    table-for-each
    table-length
    table-merge
    table-merge!
    table-ref
    table-search
    table-set!
    table?
    take
    take!
    take-right
    tanh
    tcp-client-local-socket-info
    tcp-client-peer-socket-info
    tcp-client-self-socket-info
    tcp-server-socket-info
    tcp-service-register!
    tcp-service-unregister!
    tenth
    terminated-thread-exception-arguments
    terminated-thread-exception-procedure
    terminated-thread-exception?
    test-bit-field?
    third
    thread
    thread-base-priority
    thread-base-priority-set!
    thread-group->thread-group-list
    thread-group->thread-group-vector
    thread-group->thread-list
    thread-group->thread-vector
    thread-group-name
    thread-group-parent
    thread-group-resume!
    thread-group-specific
    thread-group-specific-set!
    thread-group-suspend!
    thread-group-terminate!
    thread-group?
    thread-init!
    thread-interrupt!
    thread-join!
    thread-mailbox-extract-and-rewind
    thread-mailbox-next
    thread-mailbox-rewind
    thread-name
    thread-priority
    thread-priority-set!
    thread-priority-boost
    thread-priority-boost-set!
    thread-quantum
    thread-quantum-set!
    thread-receive
    thread-resume!
    thread-send
    thread-sleep!
    thread-specific
    thread-specific-set!
    thread-start!
    thread-state
    thread-state-abnormally-terminated-reason
    thread-state-abnormally-terminated?
    thread-state-initialized?
    thread-state-normally-terminated-result
    thread-state-normally-terminated?
    thread-state-running-processor
    thread-state-running?
    thread-state-uninitialized?
    thread-state-waiting-for
    thread-state-waiting-timeout
    thread-state-waiting?
    thread-suspend!
    thread-terminate!
    thread-thread-group
    thread-yield!
    thread?
    time->seconds
    time?
    timeout->time
    top
    touch
    trace
    tty-history
    tty-history-max-length-set!
    tty-history-set!
    tty-mode-set!
    tty-paren-balance-duration-set!
    tty-text-attributes-set!
    tty-type-set!
    tty?
    type-exception-arg-id
    type-exception-arguments
    type-exception-procedure
    type-exception-type-id
    type-exception?
    u16vector
    u16vector->list
    u16vector-append
    u16vector-concatenate
    u16vector-copy
    u16vector-copy!
    u16vector-fill!
    u16vector-length
    u16vector-ref
    u16vector-set
    u16vector-set!
    u16vector-shrink!
    u16vector-swap!
    u16vector?
    u32vector
    u32vector->list
    u32vector-append
    u32vector-concatenate
    u32vector-copy
    u32vector-copy!
    u32vector-fill!
    u32vector-length
    u32vector-ref
    u32vector-set
    u32vector-set!
    u32vector-shrink!
    u32vector-swap!
    u32vector?
    u64vector
    u64vector->list
    u64vector-append
    u64vector-concatenate
    u64vector-copy
    u64vector-copy!
    u64vector-fill!
    u64vector-length
    u64vector-ref
    u64vector-set
    u64vector-set!
    u64vector-shrink!
    u64vector-swap!
    u64vector?
    u8vector
    u8vector->list
    u8vector->object
    u8vector-append
    u8vector-concatenate
    u8vector-copy
    u8vector-copy!
    u8vector-fill!
    u8vector-length
    u8vector-ref
    u8vector-set
    u8vector-set!
    u8vector-shrink!
    u8vector-swap!
    u8vector?
    ucs-range->char-set
    ucs-range->char-set!
    udp-destination-set!
    udp-local-socket-info
    udp-read-subu8vector
    udp-read-u8vector
    udp-source-socket-info
    udp-write-subu8vector
    udp-write-u8vector
    unbound-global-exception-code
    unbound-global-exception-rte
    unbound-global-exception-variable
    unbound-global-exception?
    unbound-key-exception-arguments
    unbound-key-exception-procedure
    unbound-key-exception?
    unbound-os-environment-variable-exception-arguments
    unbound-os-environment-variable-exception-procedure
    unbound-os-environment-variable-exception?
    unbound-serial-number-exception-arguments
    unbound-serial-number-exception-procedure
    unbound-serial-number-exception?
    unbox
    unbreak
    uncaught-exception-arguments
    uncaught-exception-procedure
    uncaught-exception-reason
    uncaught-exception?
    uninitialized-thread-exception-arguments
    uninitialized-thread-exception-procedure
    uninitialized-thread-exception?
    uninterned-keyword?
    uninterned-symbol?
    unknown-keyword-argument-exception-arguments
    unknown-keyword-argument-exception-procedure
    unknown-keyword-argument-exception?
    unterminated-process-exception-arguments
    unterminated-process-exception-procedure
    unterminated-process-exception?
    untrace
    user-info
    user-info-gid
    user-info-home
    user-info-name
    user-info-shell
    user-info-uid
    user-info?
    user-name
    vector->bits
    vector-any
    vector-cas!
    vector-concatenate
    vector-cumulate
    vector-every
    vector-fold
    vector-fold-right
    vector-inc!
    vector-set
    vector-shrink!
    vector-swap!
    vector-unfold
    vector-unfold-right
    void
    will-execute!
    will-testator
    will?
    with-exception-catcher
    with-exception-handler
    with-input-from-port
    with-input-from-process
    with-input-from-string
    with-input-from-u8vector
    with-input-from-vector
    with-output-to-port
    with-output-to-process
    with-output-to-string
    with-output-to-u8vector
    with-output-to-vector
    write-file-string
    write-file-string-list
    write-file-u8vector
    write-substring
    write-subu8vector
    wrong-number-of-arguments-exception-arguments
    wrong-number-of-arguments-exception-procedure
    wrong-number-of-arguments-exception?
    wrong-number-of-values-exception-code
    wrong-number-of-values-exception-rte
    wrong-number-of-values-exception-vals
    wrong-number-of-values-exception?
    wrong-processor-c-return-exception?
    xcons
    ))

;;;
;;; procedures provided by the gerbil runtime
;;;
(module GerbilRuntime
  (export #t)
  (extern namespace: #f
    ;; :gerbil/runtime/gambit
    max-char-code

    ;; :gerbil/runtime/util
    raise-contract-violation-error
    displayln
    display*
    file-newer?
    create-directory*
    move-file
    absent-obj
    absent-value
    true
    true?
    false
    void?
    eof-object
    dssl-object?
    dssl-key-object?
    dssl-rest-object?
    dssl-optional-object?
    immediate?
    nonnegative-fixnum?
    values-count
    values-ref
    values->list
    cons*
    foldl
    foldr
    andmap
    ormap
    filter-map

    agetq
    agetv
    aget
    ;; TODO: remove after transition to the new name
    assgetq
    assgetv
    assget

    pgetq
    pgetv
    pget
    find
    memf
    remove1
    remv
    remq
    remf
    1+
    1-
    fx1+
    fx1-
    fxshift
    fx/
    fx>=0?
    fx>0?
    fx=0?
    fx<0?
    fx<=0?
    interned-symbol?
    display-as-string
    as-string
    make-symbol
    make-keyword
    interned-keyword?
    symbol->keyword
    keyword->symbol
    bytes->string
    string->bytes
    substring->bytes
    string-empty?
    string-index
    string-rindex
    string-split
    string-join
    read-u8vector
    write-u8vector

    ;; :gerbil/runtime/table
    symbolic?
    symblic-hash
    eq-hash
    eqv-hash
    procedure-hash
    string-hash
    immediate-hash

    make-symbolic-table
    symbolic-table-ref
    symbolic-table-set!
    symbolic-table-delete!

    ;; :gerbil/runtime/control
    make-promise
    call-with-parameters
    with-unwind-protect
    keyword-dispatch
    keyword-rest

    ;; :gerbil/runtime/system
    gerbil-system-manifest
    build-manifest
    build-manifest-set!
    display-build-manifest
    build-manifest/layer
    build-manifest/head
    build-manifest-string
    gerbil-version-string
    gerbil-system
    gerbil-system-version-string
    gerbil-greeting
    gerbil-greeting-set!
    gerbil-home
    gerbil-path
    gerbil-runtime-smp?

    ;; :gerbil/runtime/c3
    c4-linearize

    ;; :gerbil/runtime/mop
    class-type?
    class-type=?
    class-type-final?
    class-type-struct?
    class-type-sealed?
    class-type-metaclass?
    class-type-system?
    class-type-id
    class-type-name
    class-type-super
    class-type-flags
    class-type-fields
    class-type-precedence-list
    class-type-slot-vector
    class-type-slot-table
    class-type-properties
    class-type-constructor
    class-type-methods
    &class-type-id
    &class-type-name
    &class-type-super
    &class-type-flags
    &class-type-fields
    &class-type-precedence-list
    &class-type-slot-vector
    &class-type-slot-table
    &class-type-properties
    &class-type-constructor
    class-type-slot-list
    class-type-field-count
    class-type-seal!
    subclass?
    substruct?
    make-class-type
    make-class-predicate
    make-class-slot-accessor
    make-class-slot-mutator
    make-class-slot-unchecked-accessor
    make-class-slot-unchecked-mutator
    immediate-instance-of?
    direct-instance?
    struct-instance?
    class-instance?
    make-object
    object?
    object-type
    object-fill!
    new-instance
    make-instance
    struct-instance-init!
    class-instance-init!
    constructor-init!
    struct-copy
    struct->list
    class->list
    slot-ref
    slot-set!
    unchecked-slot-ref
    unchecked-slot-set!
    call-method
    method-ref
    checked-method-ref
    bound-method-ref
    checked-bound-method-ref
    find-method
    direct-method-ref
    bind-method!
    bind-specializer!
    seal-class!
    next-method
    call-next-method
    type-of
    class-of
    t::t
    class::t
    object::t

    ;; :gerbil/runtime/mop-system-classes
    immediate::t
    atom::t
    char::t
    boolean::t
    true::t
    false::t
    void::t
    eof::t
    special::t
    number::t
    real::t
    integer::t
    fixnum::t
    bignum::t
    ratnum::t
    flonum::t
    cpxnum::t
    symbolic::t
    symbol::t
    keyword::t
    list::t
    pair::t
    null::t
    sequence::t
    vector::t
    string::t
    hvector::t
    u8vector::t
    s8vector::t
    u16vector::t
    s16vector::t
    u32vector::t
    s32vector::t
    u64vector::t
    s64vector::t
    f32vector::t
    f64vector::t
    values::t
    box::t
    frame::t
    continuation::t
    promise::t
    weak::t
    foreign::t
    procedure::t
    return::t
    time::t
    thread::t
    thread-group::t
    mutex::t
    condvar::t
    port::t
    object-port::t
    character-port::t
    byte-port::t
    device-port::t
    vector-port::t
    string-port::t
    u8vector-port::t
    raw-device-port::t
    tcp-server-port::t
    udp-port::t
    directory-port::t
    event-queue-port::t
    table::t
    readenv::t
    writeenv::t
    readtable::t
    processor::t
    vm::t
    file-info::t
    socket-info::t
    address-info::t

    special?
    sequence?
    hvector?
    weak?
    object-port?
    character-port?
    byte-port?
    character-port?
    device-port?
    vector-port?
    string-port?
    u8vector-port?
    raw-device-port?
    tcp-server-port?
    udp-port?
    directory-port?
    event-queue-port?
    readenv?
    writenv?
    vm?

    ;; :gerbil/runtime/error
    raise
    error
    with-exception-handler
    with-catch
    with-exception-catcher
    exception?
    error?
    error-object?
    error-message
    error-irritants
    error-trace
    display-exception
    dump-stack-trace?
    datum-parsing-exception-filepos

    ;; :gerbil/runtime/interface
    interface-instance::t
    interface-instance?
    interface-instance-object
    &interface-instance-object
    make-interface-descriptor
    interface-descriptor?
    interface-descriptor-type
    interface-descriptor-methods
    cast try-cast satisfies?
    interface-cast-error?


    ;; :gerbil/runtime/hash
    raise-unbound-key-error
    unbound-key-error?
    hash-table?
    is-hash-table?

    HashTable::t
    HashTable::interface
    HashTableLock::t
    HashTableLock::interface

    make-hash-table
    make-hash-table-eq
    make-hash-table-eqv
    make-hash-table-symbolic
    make-hash-table-string
    make-hash-table-immediate
    list->hash-table
    list->hash-table-eq
    list->hash-table-eqv
    list->hash-table-symbolic
    list->hash-table-string
    list->hash-table-immediate
    plist->hash-table
    plist->hash-table-eq
    plist->hash-table-eqv
    plist->hash-table-symbolic
    plist->hash-table-string
    plist->hash-table-immediate
    hash-length
    hash-ref
    hash-get
    hash-put!
    hash-update!
    hash-remove!
    hash-key?
    hash->list
    hash->plist
    hash-for-each
    hash-map
    hash-fold
    hash-find
    hash-keys
    hash-values
    hash-copy
    hash-merge
    hash-merge!
    hash-clear!

    ;; :gerbil/runtime/thread
    spawn
    spawn/name
    spawn/group
    thread-local-ref
    thread-local-get
    thread-local-set!
    thread-local-delete!
    unhandled-actor-exception-hook-set!
    current-thread-group
    with-lock
    with-dynamic-lock
    with-exception-stack-trace
    dump-stack-trace!
    actor-thread?

    ;; :gerbil/runtime/syntax
    syntax-error?
    make-syntax-error
    AST?
    make-AST
    AST-e
    AST-source
    read-syntax
    read-syntax-from-file
    source-location?
    source-location-path?
    source-location-path

    ;; :gerbil/runtime/eval

    ;; :gerbil/runtime/repl
    replx

    ;; :gerbil/runtime/loader
    load-path
    add-load-path!
    set-load-path!
    load-module
    reload-module!
    list-modules
    module-load-order

    ;; :gerbil/runtime/init
    gerbil-load-expander!
    ))

;;;
;;; common runtime aliases
;;;
(module RuntimeAliases
  (export #t)
  (define-alias car-set! set-car!)
  (define-alias cdr-set! set-cdr!)
  (define-alias box-set! set-box!)
  (define-alias string-ref-set! string-set!)
  (define-alias vector-ref-set! vector-set!)
  (define-alias s8vector-ref-set! s8vector-set!)
  (define-alias u8vector-ref-set! u8vector-set!)
  (define-alias s16vector-ref-set! s16vector-set!)
  (define-alias u16vector-ref-set! u16vector-set!)
  (define-alias s32vector-ref-set! s32vector-set!)
  (define-alias u32vector-ref-set! u32vector-set!)
  (define-alias s64vector-ref-set! s64vector-set!)
  (define-alias u64vector-ref-set! u64vector-set!)
  (define-alias f32vector-ref-set! f32vector-set!)
  (define-alias f64vector-ref-set! f64vector-set!)

  (define-alias call/values     call-with-values)
  (define-alias call/parameters call-with-parameters)

  (define-alias random-bytes random-u8vector)
  (define-alias random-source-make-bytes random-source-make-u8vectors))

;;;
;;; aggregate runtime module -- all runtime symbols
;;;
(module Runtime
  (import R5RSRuntime
          R7RSRuntime
          GambitRuntime
          GerbilRuntime
          RuntimeAliases)
  (export (import: R5RSRuntime
                   R7RSRuntime
                   GambitRuntime
                   GerbilRuntime
                   RuntimeAliases)))

;;; get the symbols
(import Runtime)