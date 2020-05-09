using System.Collections;
using System.Collections.Generic;
using System.Linq;
using UnityEngine;

public class SpawnManager : MonoBehaviour
{
    private List<Mover> movers = new List<Mover>();
    private int moverCount = 18;
    public GameObject moverPref;
    
    // Start is called before the first frame update
    void Start()
    {
        for (int i = 0; i < moverCount; i++)
        {
            GameObject instancedMoverPref = Instantiate(moverPref, Vector3.forward * i, moverPref.gameObject.transform.rotation);
            Mover mover = instancedMoverPref.GetComponent<Mover>();
            
            if (i == 0)
            {
                mover.target = GameObject.Find("Target");
            }
            else if (movers.Count > 0)
            {
                // Target is forward mover.
                mover.target = movers[i - 1].gameObject;
            }

            movers.Add(mover);
        }
    }
}
