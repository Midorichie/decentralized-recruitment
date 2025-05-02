;; Jobs Contract
;; Manages job postings on the decentralized recruitment platform

;; Constants for error codes
(define-constant ERR_JOB_EXISTS u100)
(define-constant ERR_JOB_NOT_FOUND u101)
(define-constant ERR_UNAUTHORIZED u102)
(define-constant ERR_INVALID_ID u103)
(define-constant ERR_INVALID_TITLE u104)
(define-constant ERR_INVALID_DESCRIPTION u105)
(define-constant ERR_INVALID_SKILLS u106)
 
;; Define trait for applicants
(define-trait applicant-trait
  (
    (apply-job (uint uint (string-ascii 128)) (response uint uint))
  )
)
 
;; Jobs map: stores all job postings
(define-map jobs
  {id: uint}
  {
    employer: principal,
    title: (string-ascii 64),
    description-cid: (string-ascii 128),
    skills: (list 10 (string-ascii 32)),
    timestamp: uint,
    active: bool
  }
)

;; Validation functions
(define-private (is-valid-id (id uint))
  (> id u0)
)

(define-private (is-valid-title (title (string-ascii 64)))
  (> (len title) u0)
)

(define-private (is-valid-description (desc-cid (string-ascii 128)))
  (> (len desc-cid) u0)
)

(define-private (is-valid-skills (skills (list 10 (string-ascii 32))))
  (and
    (> (len skills) u0)
    (check-skills-length skills)
  )
)

;; Check that all skills have non-zero length
;; Instead of recursion, we'll check element by element with a limited set
(define-private (check-skills-length (skills (list 10 (string-ascii 32))))
  (let 
    ((skill-count (len skills)))
    (and
      ;; Check up to 10 elements using if-statements instead of match
      (if (>= skill-count u1) (> (len (default-to "" (element-at skills u0))) u0) true)
      (if (>= skill-count u2) (> (len (default-to "" (element-at skills u1))) u0) true)
      (if (>= skill-count u3) (> (len (default-to "" (element-at skills u2))) u0) true)
      (if (>= skill-count u4) (> (len (default-to "" (element-at skills u3))) u0) true)
      (if (>= skill-count u5) (> (len (default-to "" (element-at skills u4))) u0) true)
      (if (>= skill-count u6) (> (len (default-to "" (element-at skills u5))) u0) true)
      (if (>= skill-count u7) (> (len (default-to "" (element-at skills u6))) u0) true)
      (if (>= skill-count u8) (> (len (default-to "" (element-at skills u7))) u0) true)
      (if (>= skill-count u9) (> (len (default-to "" (element-at skills u8))) u0) true)
      (if (>= skill-count u10) (> (len (default-to "" (element-at skills u9))) u0) true)
    )
  )
)




 
;; Post a new job
(define-public (post-job (id uint) (title (string-ascii 64)) (desc-cid (string-ascii 128)) (skills (list 10 (string-ascii 32))))
  (begin
    ;; Validate inputs
    (asserts! (is-valid-id id) (err ERR_INVALID_ID))
    (asserts! (is-valid-title title) (err ERR_INVALID_TITLE))
    (asserts! (is-valid-description desc-cid) (err ERR_INVALID_DESCRIPTION))
    (asserts! (is-valid-skills skills) (err ERR_INVALID_SKILLS))
    
    ;; Check if job ID already exists
    (asserts! (is-eq (map-get? jobs {id: id}) none) (err ERR_JOB_EXISTS))
    
    ;; Insert new job
    (map-insert jobs {id: id}
                {employer: tx-sender, 
                 title: title, 
                 description-cid: desc-cid, 
                 skills: skills, 
                 timestamp: block-height, 
                 active: true})
    (ok id))
)
 
;; Get job details
(define-read-only (get-job (id uint))
  (map-get? jobs {id: id})
)
 
;; Update job status (active/inactive)
(define-public (update-job-status (id uint) (active bool))
  (begin
    ;; Validate input
    (asserts! (is-valid-id id) (err ERR_INVALID_ID))
    
    (let ((job (unwrap! (map-get? jobs {id: id}) (err ERR_JOB_NOT_FOUND))))
      ;; Verify ownership
      (asserts! (is-eq tx-sender (get employer job)) (err ERR_UNAUTHORIZED))
      
      ;; Update job status
      (map-set jobs {id: id}
               (merge job {active: active}))
      (ok true))
  )
)
