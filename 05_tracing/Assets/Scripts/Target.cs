using System;
using System.Collections;
using System.Collections.Generic;
using UnityEngine;

// Reference https://www.youtube.com/watch?v=d-c2exWNzOk
public class Target : MonoBehaviour
{
    private float posRange = 8f;
    private float duration = 1.5f;
    
    // Start is called before the first frame update
    void Start()
    {
        StartCoroutine(Loop());
    }

    IEnumerator Loop() {
        Vector3[] table = new Vector3[] {
            new Vector3(1f, 0f, posRange),
            new Vector3(posRange, -2f, 0f),
            new Vector3(2f, posRange, -4f),
            new Vector3(0f, posRange, 0f),
            new Vector3(-posRange, 2f, posRange),
            new Vector3(posRange / 2f, -3f, 0f),
        };
        int idx = 0;
        for (;;) {
            transform.position = table[idx];
            yield return new WaitForSeconds(duration);
            idx = (idx + 1) % table.Length;
        }
    }
}
