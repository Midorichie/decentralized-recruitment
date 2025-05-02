definition-version 1.0

(define-public (calculate-match (job-id uint) (app-id uint))
  (let ((job (unwrap-panic (map-get jobs {id: job-id})))
        (app (unwrap-panic (map-get applicants {id: app-id}))))
    ;; simple intersection count
    (let ((common (list-intersect (get skills job) (get applied-ids app))))
      (ok (len common)))))
