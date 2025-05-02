;; Matching Contract
;; Calculates match scores between jobs and applicants

;; Constants for error codes
(define-constant ERR_JOB_NOT_FOUND u300)
(define-constant ERR_APPLICANT_NOT_FOUND u301)
(define-constant ERR_INVALID_ID u302)
 
;; Define traits for other contracts
(define-trait job-trait
  (
    (post-job (uint (string-ascii 64) (string-ascii 128) (list 10 (string-ascii 32))) (response uint uint))
    (get-job (uint) (response {employer: principal, title: (string-ascii 64), description-cid: (string-ascii 128), skills: (list 10 (string-ascii 32)), timestamp: uint, active: bool} uint))
  )
)

(define-trait applicant-trait
  (
    (apply-job (uint uint (string-ascii 128)) (response uint uint))
    (get-applicant (uint) (response {applicant: principal, resume-cid: (string-ascii 128), applied-ids: (list 20 uint), timestamp: uint} uint))
  )
)

;; Validation functions
(define-private (is-valid-id (id uint))
  (> id u0)
)

;; Maps for local access (for development without inter-contract calls)
;; In production, these would be accessed via contract-call?
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

(define-map applicants
  {id: uint}
  {
    applicant: principal,
    resume-cid: (string-ascii 128),
    applied-ids: (list 20 uint),
    timestamp: uint
  }
)

;; Calculate match score between a job and an applicant
(define-public (calculate-match (job-id uint) (app-id uint))
  (begin
    ;; Validate inputs
    (asserts! (is-valid-id job-id) (err ERR_INVALID_ID))
    (asserts! (is-valid-id app-id) (err ERR_INVALID_ID))
    
    ;; Get job and applicant data - using local maps for development
    (let ((job (unwrap! (map-get? jobs {id: job-id}) (err ERR_JOB_NOT_FOUND)))
          (app (unwrap! (map-get? applicants {id: app-id}) (err ERR_APPLICANT_NOT_FOUND))))
      
      ;; Calculate match score based on skills
      (ok (calculate-skills-match (get skills job) (extract-skills-from-jobs app)))))
)

;; Helper function to extract skills from applicant's resume (placeholder)
;; In a real implementation, this would analyze the resume content
(define-private (extract-skills-from-jobs (applicant-data {applicant: principal, resume-cid: (string-ascii 128), applied-ids: (list 20 uint), timestamp: uint}))
  ;; For now, we're just using the applied job IDs as a proxy for skills
  ;; In a real implementation, we would extract actual skills from the resume
  (get applied-ids applicant-data)
)

;; Calculate match based on skills
;; This is a simple implementation that counts job skill matches
(define-private (calculate-skills-match (job-skills (list 10 (string-ascii 32))) (applicant-job-ids (list 20 uint)))
  ;; For a simple implementation, return the number of jobs the applicant has applied to
  ;; In a real implementation, you would use list-intersection-uint-count
  (len applicant-job-ids)
)

;; Simple list-intersection function for uint lists
;; Since we can't use interdependent functions, this is simplified to just return the count of common elements
(define-private (list-intersection-uint-count (list-a (list 20 uint)) (list-b (list 20 uint)))
  (let
    ((a0 (default-to u0 (element-at list-a u0)))
     (a1 (default-to u0 (element-at list-a u1)))
     (a2 (default-to u0 (element-at list-a u2)))
     (a3 (default-to u0 (element-at list-a u3)))
     (a4 (default-to u0 (element-at list-a u4)))
     (count u0))
    ;; Check first 5 elements (can be extended as needed)
    (+ count
       (if (and (> a0 u0) (is-in-list list-b a0)) u1 u0)
       (if (and (> a1 u0) (is-in-list list-b a1)) u1 u0)
       (if (and (> a2 u0) (is-in-list list-b a2)) u1 u0)
       (if (and (> a3 u0) (is-in-list list-b a3)) u1 u0)
       (if (and (> a4 u0) (is-in-list list-b a4)) u1 u0))
  )
)

;; Check if a value exists in a list without recursion
(define-private (is-in-list (lst (list 20 uint)) (item uint))
  (or
    (is-eq item (default-to u0 (element-at lst u0)))
    (is-eq item (default-to u0 (element-at lst u1)))
    (is-eq item (default-to u0 (element-at lst u2)))
    (is-eq item (default-to u0 (element-at lst u3)))
    (is-eq item (default-to u0 (element-at lst u4)))
    (is-eq item (default-to u0 (element-at lst u5)))
    (is-eq item (default-to u0 (element-at lst u6)))
    (is-eq item (default-to u0 (element-at lst u7)))
    (is-eq item (default-to u0 (element-at lst u8)))
    (is-eq item (default-to u0 (element-at lst u9)))
  )
)
